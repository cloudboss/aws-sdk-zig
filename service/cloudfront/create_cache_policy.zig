const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CachePolicyConfig = @import("cache_policy_config.zig").CachePolicyConfig;
const CachePolicy = @import("cache_policy.zig").CachePolicy;
const serde = @import("serde.zig");

pub const CreateCachePolicyInput = struct {
    /// A cache policy configuration.
    cache_policy_config: CachePolicyConfig,
};

pub const CreateCachePolicyOutput = struct {
    /// A cache policy.
    cache_policy: ?CachePolicy = null,

    /// The current version of the cache policy.
    e_tag: ?[]const u8 = null,

    /// The fully qualified URI of the cache policy just created.
    location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCachePolicyInput, options: CallOptions) !CreateCachePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCachePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2020-05-31/cache-policy";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CachePolicyConfig xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try serde.serializeCachePolicyConfig(allocator, &body_buf, input.cache_policy_config);
    try body_buf.appendSlice(allocator, "</CachePolicyConfig>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCachePolicyOutput {
    var result: CreateCachePolicyOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
