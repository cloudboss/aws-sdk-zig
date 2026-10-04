const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyExistenceCondition = @import("policy_existence_condition.zig").PolicyExistenceCondition;

pub const PutConfiguredAudienceModelPolicyInput = struct {
    /// The Amazon Resource Name (ARN) of the configured audience model that the
    /// resource policy will govern.
    configured_audience_model_arn: []const u8,

    /// The IAM resource policy.
    configured_audience_model_policy: []const u8,

    /// Use this to prevent unexpected concurrent modification of the policy.
    policy_existence_condition: ?PolicyExistenceCondition = null,

    /// A cryptographic hash of the contents of the policy used to prevent
    /// unexpected concurrent modification of the policy.
    previous_policy_hash: ?[]const u8 = null,

    pub const json_field_names = .{
        .configured_audience_model_arn = "configuredAudienceModelArn",
        .configured_audience_model_policy = "configuredAudienceModelPolicy",
        .policy_existence_condition = "policyExistenceCondition",
        .previous_policy_hash = "previousPolicyHash",
    };
};

pub const PutConfiguredAudienceModelPolicyOutput = struct {
    /// The IAM resource policy.
    configured_audience_model_policy: []const u8,

    /// A cryptographic hash of the contents of the policy used to prevent
    /// unexpected concurrent modification of the policy.
    policy_hash: []const u8,

    pub const json_field_names = .{
        .configured_audience_model_policy = "configuredAudienceModelPolicy",
        .policy_hash = "policyHash",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutConfiguredAudienceModelPolicyInput, options: CallOptions) !PutConfiguredAudienceModelPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutConfiguredAudienceModelPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configured-audience-model/");
    try path_buf.appendSlice(allocator, input.configured_audience_model_arn);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuredAudienceModelPolicy\":");
    try aws.json.writeValue(@TypeOf(input.configured_audience_model_policy), input.configured_audience_model_policy, allocator, &body_buf);
    has_prev = true;
    if (input.policy_existence_condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyExistenceCondition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.previous_policy_hash) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"previousPolicyHash\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutConfiguredAudienceModelPolicyOutput {
    var result: PutConfiguredAudienceModelPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutConfiguredAudienceModelPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
