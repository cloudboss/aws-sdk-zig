const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyDefinition = @import("policy_definition.zig").PolicyDefinition;
const EnforcementMode = @import("enforcement_mode.zig").EnforcementMode;
const PolicyValidationMode = @import("policy_validation_mode.zig").PolicyValidationMode;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

pub const CreatePolicyInput = struct {
    /// A unique, case-sensitive identifier to ensure the idempotency of the
    /// request. The AWS SDK automatically generates this token, so you don't need
    /// to provide it in most cases. If you retry a request with the same client
    /// token, the service returns the same response without creating a duplicate
    /// policy.
    client_token: ?[]const u8 = null,

    /// The Cedar or Dogwood policy statement that defines the access control rules.
    /// This contains the actual policy logic written in Cedar or Dogwood,
    /// specifying effect (permit or forbid), principals, actions, resources, and
    /// conditions for agent behavior control.
    definition: PolicyDefinition,

    /// A human-readable description of the policy's purpose and functionality
    /// (1-4,096 characters). This helps policy administrators understand the
    /// policy's intent, business rules, and operational scope. Use this field to
    /// document why the policy exists, what business requirement it addresses, and
    /// any special considerations for maintenance. Clear descriptions are essential
    /// for policy governance, auditing, and troubleshooting.
    description: ?[]const u8 = null,

    /// The enforcement mode for the policy. Run this policy in `LOG_ONLY` mode to
    /// collect data on how it affects your application. Once you are satisfied with
    /// the data gathered, switch the policy to `ACTIVE`. Defaults to `ACTIVE`.
    enforcement_mode: ?EnforcementMode = null,

    /// The customer-assigned immutable name for the policy. Must be unique within
    /// the account. This name is used for policy identification and cannot be
    /// changed after creation.
    name: []const u8,

    /// The identifier of the policy engine which contains this policy. Policy
    /// engines group related policies and provide the execution context for policy
    /// evaluation.
    policy_engine_id: []const u8,

    /// The validation mode for the policy creation. Determines how Cedar analyzer
    /// validation results are handled during policy creation. FAIL_ON_ANY_FINDINGS
    /// (default) runs the Cedar analyzer to validate the policy against the Cedar
    /// schema and tool context, failing creation if the analyzer detects any
    /// validation issues to ensure strict conformance. IGNORE_ALL_FINDINGS runs the
    /// Cedar analyzer but allows policy creation even if validation issues are
    /// detected, useful for testing or when the policy schema is evolving. Use
    /// FAIL_ON_ANY_FINDINGS for production policies to ensure correctness, and
    /// IGNORE_ALL_FINDINGS only when you understand and accept the analyzer
    /// findings.
    validation_mode: ?PolicyValidationMode = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .definition = "definition",
        .description = "description",
        .enforcement_mode = "enforcementMode",
        .name = "name",
        .policy_engine_id = "policyEngineId",
        .validation_mode = "validationMode",
    };
};

pub const CreatePolicyOutput = struct {
    /// The timestamp when the policy was created. This is automatically set by the
    /// service and used for auditing and lifecycle management.
    created_at: i64,

    /// The Cedar or Dogwood policy statement that was created. This is the
    /// validated policy definition that will be used for agent behavior control and
    /// access decisions.
    definition: ?PolicyDefinition = null,

    /// The human-readable description of the policy's purpose and functionality.
    /// This helps administrators understand and manage the policy.
    description: ?[]const u8 = null,

    /// The enforcement mode of the created policy.
    enforcement_mode: ?EnforcementMode = null,

    /// The customer-assigned name of the created policy. This matches the name
    /// provided in the request and serves as the human-readable identifier for the
    /// policy.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the created policy. This globally unique
    /// identifier can be used for cross-service references and IAM policy
    /// statements.
    policy_arn: []const u8,

    /// The identifier of the policy engine that manages this policy. This confirms
    /// the policy engine assignment and is used for policy evaluation routing.
    policy_engine_id: []const u8,

    /// The unique identifier for the created policy. This is a system-generated
    /// identifier consisting of the user name plus a 10-character generated suffix,
    /// used for all subsequent policy operations.
    policy_id: []const u8,

    /// The current status of the policy. A status of `ACTIVE` indicates the policy
    /// is ready for use.
    status: PolicyStatus,

    /// Additional information about the policy status. This provides details about
    /// any failures or the current state of the policy creation process.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the policy was last updated. For newly created policies,
    /// this matches the createdAt timestamp.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .definition = "definition",
        .description = "description",
        .enforcement_mode = "enforcementMode",
        .name = "name",
        .policy_arn = "policyArn",
        .policy_engine_id = "policyEngineId",
        .policy_id = "policyId",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePolicyInput, options: CallOptions) !CreatePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policies");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"definition\":");
    try aws.json.writeValue(@TypeOf(input.definition), input.definition, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enforcement_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enforcementMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.validation_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"validationMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyOutput {
    const result: CreatePolicyOutput = try aws.json.parseJsonObject(
        CreatePolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
