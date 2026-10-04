const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnforcementMode = @import("enforcement_mode.zig").EnforcementMode;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

pub const GetPolicySummaryInput = struct {
    /// The identifier of the policy engine that manages the policy to retrieve the
    /// summary for.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy to retrieve the summary for. This must
    /// be a valid policy ID that exists within the specified policy engine.
    policy_id: []const u8,

    pub const json_field_names = .{
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
    };
};

pub const GetPolicySummaryOutput = struct {
    /// The timestamp when the policy was originally created.
    created_at: i64,

    /// The current enforcement mode of the policy.
    enforcement_mode: ?EnforcementMode = null,

    /// The customer-assigned name of the policy.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: []const u8,

    /// The identifier of the policy engine that manages this policy.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy.
    policy_id: []const u8,

    /// The current status of the policy.
    status: PolicyStatus,

    /// The timestamp when the policy was last modified.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .enforcement_mode = "enforcementMode",
        .name = "name",
        .policy_arn = "policyArn",
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicySummaryInput, options: CallOptions) !GetPolicySummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicySummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policy-summaries/");
    try path_buf.appendSlice(allocator, input.policy_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicySummaryOutput {
    const result: GetPolicySummaryOutput = try aws.json.parseJsonObject(
        GetPolicySummaryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
