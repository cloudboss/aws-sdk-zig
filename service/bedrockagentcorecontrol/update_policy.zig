const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyDefinition = @import("policy_definition.zig").PolicyDefinition;
const UpdatedDescription = @import("updated_description.zig").UpdatedDescription;
const PolicyValidationMode = @import("policy_validation_mode.zig").PolicyValidationMode;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

pub const UpdatePolicyInput = struct {
    /// The new Cedar policy statement that defines the access control rules. This
    /// replaces the existing policy definition with new logic while maintaining the
    /// policy's identity.
    definition: ?PolicyDefinition = null,

    /// The new human-readable description for the policy. This optional field
    /// allows updating the policy's documentation while keeping the same policy
    /// logic.
    description: ?UpdatedDescription = null,

    /// The identifier of the policy engine that manages the policy to be updated.
    /// This ensures the policy is updated within the correct policy engine context.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy to be updated. This must be a valid
    /// policy ID that exists within the specified policy engine.
    policy_id: []const u8,

    /// The validation mode for the policy update. Determines how Cedar analyzer
    /// validation results are handled during policy updates. FAIL_ON_ANY_FINDINGS
    /// runs the Cedar analyzer and fails the update if validation issues are
    /// detected, ensuring the policy conforms to the Cedar schema and tool context.
    /// IGNORE_ALL_FINDINGS runs the Cedar analyzer but allows updates despite
    /// validation warnings. Use FAIL_ON_ANY_FINDINGS to ensure policy correctness
    /// during updates, especially when modifying policy logic or conditions.
    validation_mode: ?PolicyValidationMode = null,

    pub const json_field_names = .{
        .definition = "definition",
        .description = "description",
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
        .validation_mode = "validationMode",
    };
};

pub const UpdatePolicyOutput = struct {
    /// The original creation timestamp of the policy.
    created_at: i64,

    /// The updated Cedar policy statement.
    definition: ?PolicyDefinition = null,

    /// The updated description of the policy.
    description: ?[]const u8 = null,

    /// The name of the updated policy.
    name: []const u8,

    /// The ARN of the updated policy.
    policy_arn: []const u8,

    /// The identifier of the policy engine managing the updated policy.
    policy_engine_id: []const u8,

    /// The unique identifier of the updated policy.
    policy_id: []const u8,

    /// The current status of the updated policy.
    status: PolicyStatus,

    /// Additional information about the update status.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the policy was last updated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePolicyInput, options: CallOptions) !UpdatePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.policy_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"definition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.validation_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"validationMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePolicyOutput {
    var result: UpdatePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
