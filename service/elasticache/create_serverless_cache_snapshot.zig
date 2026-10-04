const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ServerlessCacheSnapshot = @import("serverless_cache_snapshot.zig").ServerlessCacheSnapshot;
const serde = @import("serde.zig");

pub const CreateServerlessCacheSnapshotInput = struct {
    /// The ID of the KMS key used to encrypt the snapshot. Available for Valkey,
    /// Redis OSS and Serverless Memcached only. Default: NULL
    kms_key_id: ?[]const u8 = null,

    /// The name of an existing serverless cache. The snapshot is created from this
    /// cache. Available for Valkey, Redis OSS and Serverless Memcached only.
    serverless_cache_name: []const u8,

    /// The name for the snapshot being created. Must be unique for the customer
    /// account. Available for Valkey, Redis OSS and Serverless Memcached only.
    /// Must be between 1 and 255 characters. This value is stored as a lowercase
    /// string.
    serverless_cache_snapshot_name: []const u8,

    /// A list of tags to be added to the snapshot resource. A tag is a key-value
    /// pair. Available for Valkey, Redis OSS and Serverless Memcached only.
    tags: ?[]const Tag = null,
};

pub const CreateServerlessCacheSnapshotOutput = struct {
    /// The state of a serverless cache snapshot at a specific point in time, to the
    /// millisecond. Available for Valkey, Redis OSS and Serverless Memcached only.
    serverless_cache_snapshot: ?ServerlessCacheSnapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServerlessCacheSnapshotInput, options: CallOptions) !CreateServerlessCacheSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServerlessCacheSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateServerlessCacheSnapshot&Version=2015-02-02");
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KmsKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ServerlessCacheName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.serverless_cache_name);
    try body_buf.appendSlice(allocator, "&ServerlessCacheSnapshotName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.serverless_cache_snapshot_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServerlessCacheSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateServerlessCacheSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: CreateServerlessCacheSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ServerlessCacheSnapshot")) {
                    result.serverless_cache_snapshot = try serde.deserializeServerlessCacheSnapshot(allocator, &reader);
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
