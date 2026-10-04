const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Snapshot = @import("snapshot.zig").Snapshot;
const serde = @import("serde.zig");

pub const CopySnapshotInput = struct {
    /// The ID of the KMS key used to encrypt the target snapshot.
    kms_key_id: ?[]const u8 = null,

    /// The name of an existing snapshot from which to make a copy.
    source_snapshot_name: []const u8,

    /// A list of tags to be added to this resource. A tag is a key-value pair. A
    /// tag key must
    /// be accompanied by a tag value, although null is accepted.
    tags: ?[]const Tag = null,

    /// The Amazon S3 bucket to which the snapshot is exported. This parameter is
    /// used only
    /// when exporting a snapshot for external access.
    ///
    /// When using this parameter to export a snapshot, be sure Amazon ElastiCache
    /// has the
    /// needed permissions to this S3 bucket. For more information, see [Step 2:
    /// Grant ElastiCache Access to Your Amazon S3
    /// Bucket](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html#backups-exporting-grant-access) in the
    /// *Amazon ElastiCache User Guide*.
    ///
    /// For more information, see [Exporting a
    /// Snapshot](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/backups-exporting.html) in the *Amazon ElastiCache User Guide*.
    target_bucket: ?[]const u8 = null,

    /// A name for the snapshot copy. ElastiCache does not permit overwriting a
    /// snapshot,
    /// therefore this name must be unique within its context - ElastiCache or an
    /// Amazon S3
    /// bucket if exporting. This value is stored as a lowercase string.
    target_snapshot_name: []const u8,
};

pub const CopySnapshotOutput = struct {
    snapshot: ?Snapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopySnapshotInput, options: CallOptions) !CopySnapshotOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CopySnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CopySnapshot&Version=2015-02-02");
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SourceSnapshotName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_snapshot_name);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.target_bucket) |v| {
        try body_buf.appendSlice(allocator, "&TargetBucket=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&TargetSnapshotName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.target_snapshot_name);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopySnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CopySnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: CopySnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Snapshot")) {
                    result.snapshot = try serde.deserializeSnapshot(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
