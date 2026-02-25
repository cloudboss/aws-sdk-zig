//! S3-specific endpoint resolution.
//!
//! Handles virtual-hosted-style, path-style, acceleration, FIPS,
//! and dual-stack endpoints for Amazon S3.

const std = @import("std");

const endpoint_mod = @import("endpoint.zig");
const Partition = endpoint_mod.Partition;

pub const S3EndpointError = error{
    FipsNotSupported,
    DualStackNotSupported,
    AccelerateNotSupported,
    AccelerateRequiresDnsCompatibleBucket,
};

pub const S3Endpoint = struct {
    host: []const u8,
    use_path_style: bool,
};

pub const S3EndpointOptions = struct {
    bucket: ?[]const u8 = null,
    use_path_style: bool = false,
    use_accelerate: bool = false,
    fips: bool = false,
    dual_stack: bool = false,
    endpoint_override: ?[]const u8 = null,
};

/// Returns true if the bucket name is DNS-compatible for virtual-hosted-style access.
/// A bucket is DNS-compatible when it is 3-63 characters, contains only lowercase
/// alphanumeric characters and hyphens, has no dots, and starts/ends with alphanumeric.
pub fn isDnsCompatible(bucket: []const u8) bool {
    if (bucket.len < 3 or bucket.len > 63) return false;
    if (!std.ascii.isAlphanumeric(bucket[0]) or
        !std.ascii.isAlphanumeric(bucket[bucket.len - 1]))
    {
        return false;
    }

    for (bucket) |c| {
        switch (c) {
            'a'...'z', '0'...'9', '-' => {},
            else => return false,
        }
    }
    return true;
}

/// Resolves the S3 endpoint hostname and path-style flag for a given region and options.
/// Returns an allocated host string -- caller owns memory.
pub fn resolveS3Endpoint(
    allocator: std.mem.Allocator,
    region: []const u8,
    options: S3EndpointOptions,
) (S3EndpointError || std.mem.Allocator.Error)!S3Endpoint {
    if (options.endpoint_override) |override| {
        const use_path_style = options.use_path_style or
            (if (options.bucket) |b| !isDnsCompatible(b) else false);
        return .{
            .host = try allocator.dupe(u8, override),
            .use_path_style = use_path_style,
        };
    }

    const partition = endpoint_mod.partitionForRegion(region);

    if (options.fips and !partition.supports_fips) return error.FipsNotSupported;
    if (options.dual_stack and !partition.supports_dual_stack) return error.DualStackNotSupported;

    if (options.use_accelerate) {
        if (!std.mem.eql(u8, partition.name, "aws")) return error.AccelerateNotSupported;
        if (options.fips) return error.AccelerateNotSupported;
        if (options.use_path_style) return error.AccelerateNotSupported;
        const bucket = options.bucket orelse return error.AccelerateRequiresDnsCompatibleBucket;
        if (!isDnsCompatible(bucket)) return error.AccelerateRequiresDnsCompatibleBucket;

        // Acceleration endpoints have no region component.
        const host = if (options.dual_stack)
            try std.fmt.allocPrint(
                allocator,
                "{s}.s3-accelerate.dualstack.{s}",
                .{ bucket, partition.dns_suffix },
            )
        else
            try std.fmt.allocPrint(
                allocator,
                "{s}.s3-accelerate.{s}",
                .{ bucket, partition.dns_suffix },
            );

        return .{ .host = host, .use_path_style = false };
    }

    // Build the base host (without bucket prefix).
    const base_host = if (options.fips and options.dual_stack)
        try std.fmt.allocPrint(
            allocator,
            "s3-fips.dualstack.{s}.{s}",
            .{ region, partition.dns_suffix },
        )
    else if (options.fips)
        try std.fmt.allocPrint(allocator, "s3-fips.{s}.{s}", .{ region, partition.dns_suffix })
    else if (options.dual_stack)
        // S3 dual-stack uses dns_suffix, NOT dual_stack_dns_suffix.
        try std.fmt.allocPrint(allocator, "s3.dualstack.{s}.{s}", .{ region, partition.dns_suffix })
    else
        try std.fmt.allocPrint(allocator, "s3.{s}.{s}", .{ region, partition.dns_suffix });

    const use_path_style = options.use_path_style or
        (if (options.bucket) |b| !isDnsCompatible(b) else true);

    if (!use_path_style) {
        // Virtual-hosted-style: prepend bucket to host.
        defer allocator.free(base_host);
        return .{
            .host = try std.fmt.allocPrint(allocator, "{s}.{s}", .{ options.bucket.?, base_host }),
            .use_path_style = false,
        };
    }

    return .{ .host = base_host, .use_path_style = true };
}

test "isDnsCompatible valid bucket" {
    try std.testing.expect(isDnsCompatible("my-bucket"));
}

test "isDnsCompatible dotted bucket" {
    try std.testing.expect(!isDnsCompatible("my.dotted.bucket"));
}

test "isDnsCompatible uppercase" {
    try std.testing.expect(!isDnsCompatible("MyBucket"));
}

test "isDnsCompatible too short" {
    try std.testing.expect(!isDnsCompatible("ab"));
}

test "isDnsCompatible leading hyphen" {
    try std.testing.expect(!isDnsCompatible("-bucket"));
}

test "virtual-hosted style" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(allocator, "us-east-1", .{ .bucket = "my-bucket" });
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("my-bucket.s3.us-east-1.amazonaws.com", result.host);
    try std.testing.expect(!result.use_path_style);
}

test "path-style for dotted bucket" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(allocator, "us-east-1", .{ .bucket = "my.dotted.bucket" });
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("s3.us-east-1.amazonaws.com", result.host);
    try std.testing.expect(result.use_path_style);
}

test "explicit path-style" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(
        allocator,
        "us-east-1",
        .{ .bucket = "my-bucket", .use_path_style = true },
    );
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("s3.us-east-1.amazonaws.com", result.host);
    try std.testing.expect(result.use_path_style);
}

test "dual-stack" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(
        allocator,
        "us-east-1",
        .{ .bucket = "my-bucket", .dual_stack = true },
    );
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings(
        "my-bucket.s3.dualstack.us-east-1.amazonaws.com",
        result.host,
    );
}

test "fips" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(allocator, "us-east-1", .{ .fips = true });
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("s3-fips.us-east-1.amazonaws.com", result.host);
}

test "acceleration" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(
        allocator,
        "us-east-1",
        .{ .bucket = "my-bucket", .use_accelerate = true },
    );
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("my-bucket.s3-accelerate.amazonaws.com", result.host);
    try std.testing.expect(!result.use_path_style);
}

test "acceleration with fips returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.AccelerateNotSupported,
        resolveS3Endpoint(
            allocator,
            "us-east-1",
            .{ .bucket = "my-bucket", .use_accelerate = true, .fips = true },
        ),
    );
}

test "acceleration on cn-north-1 returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.AccelerateNotSupported,
        resolveS3Endpoint(
            allocator,
            "cn-north-1",
            .{ .bucket = "my-bucket", .use_accelerate = true },
        ),
    );
}

test "fips on cn-north-1 returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.FipsNotSupported,
        resolveS3Endpoint(allocator, "cn-north-1", .{ .fips = true }),
    );
}

test "dual-stack on us-iso-east-1 returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.DualStackNotSupported,
        resolveS3Endpoint(allocator, "us-iso-east-1", .{ .dual_stack = true }),
    );
}

test "s3 virtual-hosted cn" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(allocator, "cn-north-1", .{ .bucket = "my-bucket" });
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("my-bucket.s3.cn-north-1.amazonaws.com.cn", result.host);
    try std.testing.expect(!result.use_path_style);
}

test "s3 virtual-hosted govcloud" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(allocator, "us-gov-west-1", .{ .bucket = "my-bucket" });
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("my-bucket.s3.us-gov-west-1.amazonaws.com", result.host);
    try std.testing.expect(!result.use_path_style);
}

test "s3 fips+dual_stack" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(
        allocator,
        "us-east-1",
        .{ .fips = true, .dual_stack = true },
    );
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("s3-fips.dualstack.us-east-1.amazonaws.com", result.host);
    try std.testing.expect(result.use_path_style);
}

test "s3 acceleration+dual_stack" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(
        allocator,
        "us-east-1",
        .{
            .bucket = "my-bucket",
            .use_accelerate = true,
            .dual_stack = true,
        },
    );
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings(
        "my-bucket.s3-accelerate.dualstack.amazonaws.com",
        result.host,
    );
    try std.testing.expect(!result.use_path_style);
}

test "s3 acceleration with path-style returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.AccelerateNotSupported,
        resolveS3Endpoint(
            allocator,
            "us-east-1",
            .{
                .bucket = "my-bucket",
                .use_accelerate = true,
                .use_path_style = true,
            },
        ),
    );
}

test "s3 acceleration without bucket returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.AccelerateRequiresDnsCompatibleBucket,
        resolveS3Endpoint(allocator, "us-east-1", .{ .use_accelerate = true }),
    );
}

test "s3 acceleration with dotted bucket returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.AccelerateRequiresDnsCompatibleBucket,
        resolveS3Endpoint(
            allocator,
            "us-east-1",
            .{ .bucket = "my.dotted.bucket", .use_accelerate = true },
        ),
    );
}

test "s3 no bucket path-style" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(allocator, "us-east-1", .{});
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("s3.us-east-1.amazonaws.com", result.host);
    try std.testing.expect(result.use_path_style);
}

test "s3 endpoint override with bucket" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(
        allocator,
        "us-east-1",
        .{ .bucket = "test", .endpoint_override = "localhost:4566" },
    );
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("localhost:4566", result.host);
    try std.testing.expect(!result.use_path_style);
}

test "s3 endpoint override with dotted bucket" {
    const allocator = std.testing.allocator;
    const result = try resolveS3Endpoint(
        allocator,
        "us-east-1",
        .{
            .bucket = "my.dotted.bucket",
            .endpoint_override = "localhost:4566",
        },
    );
    defer allocator.free(result.host);
    try std.testing.expectEqualStrings("localhost:4566", result.host);
    try std.testing.expect(result.use_path_style);
}
