const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerlessCacheSnapshot = @import("serverless_cache_snapshot.zig").ServerlessCacheSnapshot;
const serde = @import("serde.zig");

pub const ExportServerlessCacheSnapshotInput = struct {
    /// Name of the Amazon S3 bucket to export the snapshot to. The Amazon S3 bucket
    /// must also be in same region
    /// as the snapshot. Available for Valkey and Redis OSS only.
    s3_bucket_name: []const u8,

    /// The identifier of the serverless cache snapshot to be exported to S3.
    /// Available for Valkey and Redis OSS only.
    serverless_cache_snapshot_name: []const u8,
};

pub const ExportServerlessCacheSnapshotOutput = struct {
    /// The state of a serverless cache at a specific point in time, to the
    /// millisecond. Available for Valkey, Redis OSS and Serverless Memcached only.
    serverless_cache_snapshot: ?ServerlessCacheSnapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportServerlessCacheSnapshotInput, options: CallOptions) !ExportServerlessCacheSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportServerlessCacheSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ExportServerlessCacheSnapshot&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&S3BucketName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.s3_bucket_name);
    try body_buf.appendSlice(allocator, "&ServerlessCacheSnapshotName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.serverless_cache_snapshot_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportServerlessCacheSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExportServerlessCacheSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: ExportServerlessCacheSnapshotOutput = .{};
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
