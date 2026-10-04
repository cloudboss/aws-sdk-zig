const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OriginRequestPolicyConfig = @import("origin_request_policy_config.zig").OriginRequestPolicyConfig;
const serde = @import("serde.zig");

pub const GetOriginRequestPolicyConfigInput = struct {
    /// The unique identifier for the origin request policy. If the origin request
    /// policy is attached to a distribution's cache behavior, you can get the
    /// policy's identifier using `ListDistributions` or `GetDistribution`. If the
    /// origin request policy is not attached to a cache behavior, you can get the
    /// identifier using `ListOriginRequestPolicies`.
    id: []const u8,
};

pub const GetOriginRequestPolicyConfigOutput = struct {
    /// The current version of the origin request policy.
    e_tag: ?[]const u8 = null,

    /// The origin request policy configuration.
    origin_request_policy_config: ?OriginRequestPolicyConfig = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOriginRequestPolicyConfigInput, options: CallOptions) !GetOriginRequestPolicyConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOriginRequestPolicyConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/origin-request-policy/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/config");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOriginRequestPolicyConfigOutput {
    var result: GetOriginRequestPolicyConfigOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
