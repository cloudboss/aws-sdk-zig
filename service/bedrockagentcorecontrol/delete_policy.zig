const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyDefinition = @import("policy_definition.zig").PolicyDefinition;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

pub const DeletePolicyInput = struct {
    /// The identifier of the policy engine that manages the policy to be deleted.
    /// This ensures the policy is deleted from the correct policy engine context.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy to be deleted. This must be a valid
    /// policy ID that exists within the specified policy engine.
    policy_id: []const u8,

    pub const json_field_names = .{
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
    };
};

pub const DeletePolicyOutput = struct {
    /// The timestamp when the deleted policy was originally created.
    created_at: i64,

    definition: ?PolicyDefinition = null,

    /// The human-readable description of the deleted policy.
    description: ?[]const u8 = null,

    /// The customer-assigned name of the deleted policy. This confirms which policy
    /// was successfully removed from the system and matches the name that was
    /// originally assigned during policy creation.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the deleted policy. This globally unique
    /// identifier confirms which policy resource was successfully removed.
    policy_arn: []const u8,

    /// The identifier of the policy engine from which the policy was deleted. This
    /// confirms the policy engine context for the deletion operation.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy being deleted. This confirms which
    /// policy the deletion operation targets.
    policy_id: []const u8,

    /// The status of the policy deletion operation. This provides information about
    /// any issues that occurred during the deletion process.
    status: PolicyStatus,

    /// Additional information about the deletion status. This provides details
    /// about the deletion process or any issues that may have occurred.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the deleted policy was last modified before deletion.
    /// This tracks the final state of the policy before it was removed from the
    /// system.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .definition = "definition",
        .description = "description",
        .name = "name",
        .policy_arn = "policyArn",
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePolicyInput, options: CallOptions) !DeletePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.policy_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePolicyOutput {
    var result: DeletePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeletePolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
