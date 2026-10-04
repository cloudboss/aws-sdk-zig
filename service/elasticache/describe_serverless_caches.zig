const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerlessCache = @import("serverless_cache.zig").ServerlessCache;
const serde = @import("serde.zig");

pub const DescribeServerlessCachesInput = struct {
    /// The maximum number of records in the response. If more records exist than
    /// the specified max-records value,
    /// the next token is included in the response so that remaining results can be
    /// retrieved.
    /// The default is 50.
    max_results: ?i32 = null,

    /// An optional marker returned from a prior request to support pagination of
    /// results from this operation.
    /// If this parameter is specified, the response includes only records beyond
    /// the marker,
    /// up to the value specified by MaxResults.
    next_token: ?[]const u8 = null,

    /// The identifier for the serverless cache. If this parameter is specified,
    /// only information about that specific serverless cache is returned. Default:
    /// NULL
    serverless_cache_name: ?[]const u8 = null,
};

pub const DescribeServerlessCachesOutput = struct {
    /// An optional marker returned from a prior request to support pagination of
    /// results from this operation.
    /// If this parameter is specified, the response includes only records beyond
    /// the marker,
    /// up to the value specified by MaxResults.
    next_token: ?[]const u8 = null,

    /// The serverless caches associated with a given description request.
    serverless_caches: ?[]const ServerlessCache = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServerlessCachesInput, options: CallOptions) !DescribeServerlessCachesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServerlessCachesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeServerlessCaches&Version=2015-02-02");
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.serverless_cache_name) |v| {
        try body_buf.appendSlice(allocator, "&ServerlessCacheName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServerlessCachesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeServerlessCachesResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeServerlessCachesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessCaches")) {
                    result.serverless_caches = try serde.deserializeServerlessCacheList(allocator, &reader, "member");
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
