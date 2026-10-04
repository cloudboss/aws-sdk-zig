const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetConfiguredAudienceModelPolicyInput = struct {
    /// The Amazon Resource Name (ARN) of the configured audience model that you are
    /// interested in.
    configured_audience_model_arn: []const u8,

    pub const json_field_names = .{
        .configured_audience_model_arn = "configuredAudienceModelArn",
    };
};

pub const GetConfiguredAudienceModelPolicyOutput = struct {
    /// The Amazon Resource Name (ARN) of the configured audience model.
    configured_audience_model_arn: []const u8,

    /// The configured audience model policy. This is a JSON IAM resource policy.
    configured_audience_model_policy: []const u8,

    /// A cryptographic hash of the contents of the policy used to prevent
    /// unexpected concurrent modification of the policy.
    policy_hash: []const u8,

    pub const json_field_names = .{
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .configured_audience_model_policy = "configuredAudienceModelPolicy",
        .policy_hash = "policyHash",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfiguredAudienceModelPolicyInput, options: CallOptions) !GetConfiguredAudienceModelPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfiguredAudienceModelPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configured-audience-model/");
    try path_buf.appendSlice(allocator, input.configured_audience_model_arn);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfiguredAudienceModelPolicyOutput {
    var result: GetConfiguredAudienceModelPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConfiguredAudienceModelPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
