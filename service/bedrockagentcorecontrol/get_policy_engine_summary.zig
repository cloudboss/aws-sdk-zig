const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyEngineStatus = @import("policy_engine_status.zig").PolicyEngineStatus;

pub const GetPolicyEngineSummaryInput = struct {
    /// The unique identifier of the policy engine to retrieve the summary for. This
    /// must be a valid policy engine ID that exists within the account.
    policy_engine_id: []const u8,

    pub const json_field_names = .{
        .policy_engine_id = "policyEngineId",
    };
};

pub const GetPolicyEngineSummaryOutput = struct {
    /// The timestamp when the policy engine was originally created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the policy
    /// engine data.
    encryption_key_arn: ?[]const u8 = null,

    /// The customer-assigned name of the policy engine.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy engine.
    policy_engine_arn: []const u8,

    /// The unique identifier of the policy engine.
    policy_engine_id: []const u8,

    /// The current status of the policy engine.
    status: PolicyEngineStatus,

    /// The timestamp when the policy engine was last modified.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .encryption_key_arn = "encryptionKeyArn",
        .name = "name",
        .policy_engine_arn = "policyEngineArn",
        .policy_engine_id = "policyEngineId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyEngineSummaryInput, options: CallOptions) !GetPolicyEngineSummaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicyEngineSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engine-summaries/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicyEngineSummaryOutput {
    const result: GetPolicyEngineSummaryOutput = try aws.json.parseJsonObject(
        GetPolicyEngineSummaryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
