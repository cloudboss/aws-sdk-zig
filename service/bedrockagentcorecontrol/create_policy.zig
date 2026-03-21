const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDefinition = @import("policy_definition.zig").PolicyDefinition;
const PolicyValidationMode = @import("policy_validation_mode.zig").PolicyValidationMode;
const PolicyStatus = @import("policy_status.zig").PolicyStatus;

pub const CreatePolicyInput = struct {
    /// A unique, case-sensitive identifier to ensure the idempotency of the
    /// request. The AWS SDK automatically generates this token, so you don't need
    /// to provide it in most cases. If you retry a request with the same client
    /// token, the service returns the same response without creating a duplicate
    /// policy.
    client_token: ?[]const u8 = null,

    /// The Cedar policy statement that defines the access control rules. This
    /// contains the actual policy logic written in Cedar policy language,
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
        .name = "name",
        .policy_engine_id = "policyEngineId",
        .validation_mode = "validationMode",
    };
};

pub const CreatePolicyOutput = struct {
    /// The timestamp when the policy was created. This is automatically set by the
    /// service and used for auditing and lifecycle management.
    created_at: i64,

    /// The Cedar policy statement that was created. This is the validated policy
    /// definition that will be used for agent behavior control and access
    /// decisions.
    definition: ?PolicyDefinition = null,

    /// The human-readable description of the policy's purpose and functionality.
    /// This helps administrators understand and manage the policy.
    description: ?[]const u8 = null,

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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock-agentcore");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policies");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyOutput {
    var result: CreatePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .decryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .encryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
