const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContinuousDeploymentPolicyConfig = @import("continuous_deployment_policy_config.zig").ContinuousDeploymentPolicyConfig;
const ContinuousDeploymentPolicy = @import("continuous_deployment_policy.zig").ContinuousDeploymentPolicy;
const serde = @import("serde.zig");

pub const UpdateContinuousDeploymentPolicyInput = struct {
    /// The continuous deployment policy configuration.
    continuous_deployment_policy_config: ContinuousDeploymentPolicyConfig,

    /// The identifier of the continuous deployment policy that you are updating.
    id: []const u8,

    /// The current version (`ETag` value) of the continuous deployment policy that
    /// you are updating.
    if_match: ?[]const u8 = null,
};

pub const UpdateContinuousDeploymentPolicyOutput = struct {
    /// A continuous deployment policy.
    continuous_deployment_policy: ?ContinuousDeploymentPolicy = null,

    /// The version identifier for the current version of the continuous deployment
    /// policy.
    e_tag: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContinuousDeploymentPolicyInput, options: CallOptions) !UpdateContinuousDeploymentPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContinuousDeploymentPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/continuous-deployment-policy/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<ContinuousDeploymentPolicyConfig xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try serde.serializeContinuousDeploymentPolicyConfig(allocator, &body_buf, input.continuous_deployment_policy_config);
    try body_buf.appendSlice(allocator, "</ContinuousDeploymentPolicyConfig>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContinuousDeploymentPolicyOutput {
    var result: UpdateContinuousDeploymentPolicyOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
