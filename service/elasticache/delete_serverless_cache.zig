const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerlessCache = @import("serverless_cache.zig").ServerlessCache;
const serde = @import("serde.zig");

pub const DeleteServerlessCacheInput = struct {
    /// Name of the final snapshot to be taken before the serverless cache is
    /// deleted. Available for Valkey, Redis OSS and Serverless Memcached only.
    /// Default: NULL, i.e. a final snapshot is not taken.
    final_snapshot_name: ?[]const u8 = null,

    /// The identifier of the serverless cache to be deleted.
    serverless_cache_name: []const u8,
};

pub const DeleteServerlessCacheOutput = struct {
    /// Provides the details of the specified serverless cache that is about to be
    /// deleted.
    serverless_cache: ?ServerlessCache = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteServerlessCacheInput, options: CallOptions) !DeleteServerlessCacheOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteServerlessCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteServerlessCache&Version=2015-02-02");
    if (input.final_snapshot_name) |v| {
        try body_buf.appendSlice(allocator, "&FinalSnapshotName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ServerlessCacheName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.serverless_cache_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteServerlessCacheOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteServerlessCacheResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteServerlessCacheOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ServerlessCache")) {
                    result.serverless_cache = try serde.deserializeServerlessCache(allocator, &reader);
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
