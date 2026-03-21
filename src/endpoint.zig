//! AWS Partition-Aware Endpoint Resolver
//!
//! Resolves service endpoints for all 8 AWS partitions.
//! For S3-specific endpoint resolution, use s3_endpoint.zig instead.

const std = @import("std");

pub const Partition = struct {
    name: []const u8,
    dns_suffix: []const u8,
    dual_stack_dns_suffix: []const u8,
    supports_fips: bool,
    supports_dual_stack: bool,
};

pub const EndpointOptions = struct {
    fips: bool = false,
    dual_stack: bool = false,
    /// If non-null, return this verbatim (custom endpoint override).
    endpoint_override: ?[]const u8 = null,
};

pub const EndpointError = error{
    FipsNotSupported,
    DualStackNotSupported,
};

// Partition table -- ordered from most-specific to least-specific prefix.
// IMPORTANT: us-isob- must come before us-iso- to avoid false match.
const PARTITIONS = [_]struct { prefix: []const u8, partition: Partition }{
    .{ .prefix = "cn-", .partition = .{
        .name = "aws-cn",
        .dns_suffix = "amazonaws.com.cn",
        .dual_stack_dns_suffix = "api.amazonwebservices.com.cn",
        .supports_fips = false,
        .supports_dual_stack = true,
    } },
    .{ .prefix = "us-gov-", .partition = .{
        .name = "aws-us-gov",
        .dns_suffix = "amazonaws.com",
        .dual_stack_dns_suffix = "api.aws",
        .supports_fips = true,
        .supports_dual_stack = true,
    } },
    .{ .prefix = "us-isob-", .partition = .{
        .name = "aws-iso-b",
        .dns_suffix = "sc2s.sgov.gov",
        .dual_stack_dns_suffix = "api.aws.scloud",
        .supports_fips = true,
        .supports_dual_stack = false,
    } },
    .{ .prefix = "us-iso-", .partition = .{
        .name = "aws-iso",
        .dns_suffix = "c2s.ic.gov",
        .dual_stack_dns_suffix = "api.aws.ic.gov",
        .supports_fips = true,
        .supports_dual_stack = false,
    } },
    .{ .prefix = "eu-isoe-", .partition = .{
        .name = "aws-iso-e",
        .dns_suffix = "cloud.adc-e.uk",
        .dual_stack_dns_suffix = "api.cloud-aws.adc-e.uk",
        .supports_fips = true,
        .supports_dual_stack = false,
    } },
    .{ .prefix = "us-isof-", .partition = .{
        .name = "aws-iso-f",
        .dns_suffix = "csp.hci.ic.gov",
        .dual_stack_dns_suffix = "api.aws.hci.ic.gov",
        .supports_fips = true,
        .supports_dual_stack = false,
    } },
    .{ .prefix = "eusc-", .partition = .{
        .name = "aws-eusc",
        .dns_suffix = "amazonaws.eu",
        .dual_stack_dns_suffix = "api.amazonwebservices.eu",
        .supports_fips = true,
        .supports_dual_stack = true,
    } },
};

const AWS_PARTITION = Partition{
    .name = "aws",
    .dns_suffix = "amazonaws.com",
    .dual_stack_dns_suffix = "api.aws",
    .supports_fips = true,
    .supports_dual_stack = true,
};

/// Returns the partition for a given region string.
pub fn partitionForRegion(region: []const u8) Partition {
    for (PARTITIONS) |entry| {
        if (std.mem.startsWith(u8, region, entry.prefix)) {
            return entry.partition;
        }
    }
    return AWS_PARTITION;
}

/// Resolves the endpoint hostname (no scheme, no trailing slash) for a given
/// service + region + options. Returns allocated string -- caller owns memory.
/// For S3, do NOT call this -- use s3_endpoint.zig instead.
pub fn resolveEndpoint(
    allocator: std.mem.Allocator,
    service: []const u8,
    region: []const u8,
    options: EndpointOptions,
) (EndpointError || std.mem.Allocator.Error)![]const u8 {
    if (options.endpoint_override) |override| {
        return allocator.dupe(u8, override);
    }

    // Route53 uses a global endpoint in the aws partition.
    if (std.mem.eql(u8, service, "route53") and
        std.mem.eql(u8, partitionForRegion(region).name, "aws") and
        !options.fips and !options.dual_stack)
    {
        return allocator.dupe(u8, "route53.amazonaws.com");
    }

    // CloudFront uses a global endpoint in the aws partition.
    if (std.mem.eql(u8, service, "cloudfront") and
        std.mem.eql(u8, partitionForRegion(region).name, "aws") and
        !options.fips and !options.dual_stack)
    {
        return allocator.dupe(u8, "cloudfront.amazonaws.com");
    }

    // Global Accelerator endpoint is anchored to us-west-2 in aws partition.
    if (std.mem.eql(u8, service, "globalaccelerator") and
        std.mem.eql(u8, partitionForRegion(region).name, "aws") and
        !options.fips and !options.dual_stack)
    {
        return allocator.dupe(u8, "globalaccelerator.amazonaws.com");
    }

    // Network Manager endpoint is anchored to us-west-2 in aws partition.
    if (std.mem.eql(u8, service, "networkmanager") and
        std.mem.eql(u8, partitionForRegion(region).name, "aws") and
        !options.fips and !options.dual_stack)
    {
        return allocator.dupe(u8, "networkmanager.us-west-2.amazonaws.com");
    }

    const partition = partitionForRegion(region);

    if (options.fips and !partition.supports_fips) return error.FipsNotSupported;
    if (options.dual_stack and !partition.supports_dual_stack) return error.DualStackNotSupported;

    if (options.fips and options.dual_stack) {
        return std.fmt.allocPrint(
            allocator,
            "{s}-fips.{s}.{s}",
            .{ service, region, partition.dual_stack_dns_suffix },
        );
    } else if (options.fips) {
        return std.fmt.allocPrint(
            allocator,
            "{s}-fips.{s}.{s}",
            .{ service, region, partition.dns_suffix },
        );
    } else if (options.dual_stack) {
        return std.fmt.allocPrint(
            allocator,
            "{s}.{s}.{s}",
            .{ service, region, partition.dual_stack_dns_suffix },
        );
    } else {
        return std.fmt.allocPrint(
            allocator,
            "{s}.{s}.{s}",
            .{ service, region, partition.dns_suffix },
        );
    }
}

test "resolveEndpoint route53 uses global endpoint in aws partition" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "route53", "us-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("route53.amazonaws.com", host);
}

test "resolveEndpoint route53 fips falls through to regional" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "route53", "us-east-1", .{ .fips = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("route53-fips.us-east-1.amazonaws.com", host);
}

test "resolveEndpoint route53 dual_stack falls through to regional" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "route53", "us-east-1", .{ .dual_stack = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("route53.us-east-1.api.aws", host);
}

test "resolveEndpoint route53 govcloud falls through to regional" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "route53", "us-gov-west-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("route53.us-gov-west-1.amazonaws.com", host);
}

test "resolveEndpoint cloudfront uses global endpoint in aws partition" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "cloudfront", "us-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("cloudfront.amazonaws.com", host);
}

test "resolveEndpoint globalaccelerator uses global endpoint in aws partition" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "globalaccelerator", "us-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("globalaccelerator.amazonaws.com", host);
}

test "resolveEndpoint networkmanager uses us-west-2 endpoint in aws partition" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "networkmanager", "us-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("networkmanager.us-west-2.amazonaws.com", host);
}

test "partitionForRegion aws" {
    const p = partitionForRegion("us-east-1");
    try std.testing.expectEqualStrings("aws", p.name);
}

test "partitionForRegion aws-cn" {
    const p = partitionForRegion("cn-north-1");
    try std.testing.expectEqualStrings("aws-cn", p.name);
}

test "partitionForRegion aws-us-gov" {
    const p = partitionForRegion("us-gov-west-1");
    try std.testing.expectEqualStrings("aws-us-gov", p.name);
}

test "partitionForRegion aws-iso" {
    const p = partitionForRegion("us-iso-east-1");
    try std.testing.expectEqualStrings("aws-iso", p.name);
}

test "partitionForRegion aws-iso-b (not aws-iso)" {
    const p = partitionForRegion("us-isob-east-1");
    try std.testing.expectEqualStrings("aws-iso-b", p.name);
}

test "partitionForRegion aws-iso-e" {
    const p = partitionForRegion("eu-isoe-west-1");
    try std.testing.expectEqualStrings("aws-iso-e", p.name);
}

test "partitionForRegion aws-iso-f" {
    const p = partitionForRegion("us-isof-east-1");
    try std.testing.expectEqualStrings("aws-iso-f", p.name);
}

test "partitionForRegion aws-eusc" {
    const p = partitionForRegion("eusc-de-east-1");
    try std.testing.expectEqualStrings("aws-eusc", p.name);
}

test "resolveEndpoint default" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.us-east-1.amazonaws.com", host);
}

test "resolveEndpoint fips" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-east-1", .{ .fips = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts-fips.us-east-1.amazonaws.com", host);
}

test "resolveEndpoint dual_stack" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-east-1", .{ .dual_stack = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.us-east-1.api.aws", host);
}

test "resolveEndpoint fips cn returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.FipsNotSupported,
        resolveEndpoint(allocator, "sts", "cn-north-1", .{ .fips = true }),
    );
}

test "resolveEndpoint dual_stack iso returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.DualStackNotSupported,
        resolveEndpoint(allocator, "sts", "us-iso-east-1", .{ .dual_stack = true }),
    );
}

test "resolveEndpoint endpoint_override" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(
        allocator,
        "sts",
        "us-east-1",
        .{ .endpoint_override = "custom.example.com" },
    );
    defer allocator.free(host);
    try std.testing.expectEqualStrings("custom.example.com", host);
}

test "resolveEndpoint fips+dual_stack" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(
        allocator,
        "sts",
        "us-east-1",
        .{ .fips = true, .dual_stack = true },
    );
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts-fips.us-east-1.api.aws", host);
}

test "resolveEndpoint cn standard" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "cn-north-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.cn-north-1.amazonaws.com.cn", host);
}

test "resolveEndpoint cn dual_stack" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "cn-north-1", .{ .dual_stack = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.cn-north-1.api.amazonwebservices.com.cn", host);
}

test "resolveEndpoint govcloud standard" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-gov-west-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.us-gov-west-1.amazonaws.com", host);
}

test "resolveEndpoint govcloud fips" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-gov-west-1", .{ .fips = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts-fips.us-gov-west-1.amazonaws.com", host);
}

test "resolveEndpoint govcloud dual_stack" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-gov-west-1", .{ .dual_stack = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.us-gov-west-1.api.aws", host);
}

test "resolveEndpoint iso standard" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-iso-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.us-iso-east-1.c2s.ic.gov", host);
}

test "resolveEndpoint iso fips" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-iso-east-1", .{ .fips = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts-fips.us-iso-east-1.c2s.ic.gov", host);
}

test "resolveEndpoint iso-b standard" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-isob-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.us-isob-east-1.sc2s.sgov.gov", host);
}

test "resolveEndpoint iso-b dual_stack returns error" {
    const allocator = std.testing.allocator;
    try std.testing.expectError(
        error.DualStackNotSupported,
        resolveEndpoint(allocator, "sts", "us-isob-east-1", .{ .dual_stack = true }),
    );
}

test "resolveEndpoint iso-e standard" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "eu-isoe-west-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.eu-isoe-west-1.cloud.adc-e.uk", host);
}

test "resolveEndpoint iso-f standard" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "us-isof-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.us-isof-east-1.csp.hci.ic.gov", host);
}

test "resolveEndpoint eusc standard" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "eusc-de-east-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.eusc-de-east-1.amazonaws.eu", host);
}

test "resolveEndpoint eusc fips" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "eusc-de-east-1", .{ .fips = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts-fips.eusc-de-east-1.amazonaws.eu", host);
}

test "resolveEndpoint eusc dual_stack" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "eusc-de-east-1", .{ .dual_stack = true });
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.eusc-de-east-1.api.amazonwebservices.eu", host);
}

test "resolveEndpoint unknown region falls back to aws" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(allocator, "sts", "mars-west-1", .{});
    defer allocator.free(host);
    try std.testing.expectEqualStrings("sts.mars-west-1.amazonaws.com", host);
}

test "resolveEndpoint override ignores fips and region" {
    const allocator = std.testing.allocator;
    const host = try resolveEndpoint(
        allocator,
        "sts",
        "cn-north-1",
        .{ .fips = true, .endpoint_override = "localhost:4566" },
    );
    defer allocator.free(host);
    try std.testing.expectEqualStrings("localhost:4566", host);
}
