const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UpdatedAuthorizerConfiguration = @import("updated_authorizer_configuration.zig").UpdatedAuthorizerConfiguration;
const HarnessEnvironmentProviderRequest = @import("harness_environment_provider_request.zig").HarnessEnvironmentProviderRequest;
const UpdatedHarnessEnvironmentArtifact = @import("updated_harness_environment_artifact.zig").UpdatedHarnessEnvironmentArtifact;
const UpdatedHarnessMemoryConfiguration = @import("updated_harness_memory_configuration.zig").UpdatedHarnessMemoryConfiguration;
const HarnessModelConfiguration = @import("harness_model_configuration.zig").HarnessModelConfiguration;
const HarnessSkill = @import("harness_skill.zig").HarnessSkill;
const HarnessSystemContentBlock = @import("harness_system_content_block.zig").HarnessSystemContentBlock;
const HarnessTool = @import("harness_tool.zig").HarnessTool;
const HarnessTruncationConfiguration = @import("harness_truncation_configuration.zig").HarnessTruncationConfiguration;
const Harness = @import("harness.zig").Harness;

pub const UpdateHarnessInput = struct {
    /// The tools that the agent is allowed to use. If specified, this replaces all
    /// existing allowed tools. If not specified, the existing value is retained.
    allowed_tools: ?[]const []const u8 = null,

    authorizer_configuration: ?UpdatedAuthorizerConfiguration = null,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The compute environment configuration for the harness. If not specified, the
    /// existing value is retained.
    environment: ?HarnessEnvironmentProviderRequest = null,

    /// The environment artifact for the harness. Use the optionalValue wrapper to
    /// set a new value, or set it to null to clear the existing configuration.
    environment_artifact: ?UpdatedHarnessEnvironmentArtifact = null,

    /// Environment variables to set in the harness runtime environment. If
    /// specified, this replaces all existing environment variables. If not
    /// specified, the existing value is retained.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the IAM role that the harness assumes when running. If not
    /// specified, the existing value is retained.
    execution_role_arn: ?[]const u8 = null,

    /// The ID of the harness to update.
    harness_id: []const u8,

    /// The maximum number of iterations the agent loop can execute per invocation.
    /// If not specified, the existing value is retained.
    max_iterations: ?i32 = null,

    /// The maximum number of tokens the agent can generate per iteration. If not
    /// specified, the existing value is retained.
    max_tokens: ?i32 = null,

    /// The AgentCore Memory configuration. Use the optionalValue wrapper to set a
    /// new value, or set it to null to clear the existing configuration.
    memory: ?UpdatedHarnessMemoryConfiguration = null,

    /// The model configuration for the harness. If not specified, the existing
    /// value is retained.
    model: ?HarnessModelConfiguration = null,

    /// The skills available to the agent. If specified, this replaces all existing
    /// skills. If not specified, the existing value is retained.
    skills: ?[]const HarnessSkill = null,

    /// The system prompt that defines the agent's behavior. If not specified, the
    /// existing value is retained.
    system_prompt: ?[]const HarnessSystemContentBlock = null,

    /// The maximum duration in seconds for the agent loop execution per invocation.
    /// If not specified, the existing value is retained.
    timeout_seconds: ?i32 = null,

    /// The tools available to the agent. If specified, this replaces all existing
    /// tools. If not specified, the existing value is retained.
    tools: ?[]const HarnessTool = null,

    /// The truncation configuration for managing conversation context. If not
    /// specified, the existing value is retained.
    truncation: ?HarnessTruncationConfiguration = null,

    pub const json_field_names = .{
        .allowed_tools = "allowedTools",
        .authorizer_configuration = "authorizerConfiguration",
        .client_token = "clientToken",
        .environment = "environment",
        .environment_artifact = "environmentArtifact",
        .environment_variables = "environmentVariables",
        .execution_role_arn = "executionRoleArn",
        .harness_id = "harnessId",
        .max_iterations = "maxIterations",
        .max_tokens = "maxTokens",
        .memory = "memory",
        .model = "model",
        .skills = "skills",
        .system_prompt = "systemPrompt",
        .timeout_seconds = "timeoutSeconds",
        .tools = "tools",
        .truncation = "truncation",
    };
};

pub const UpdateHarnessOutput = struct {
    /// The updated harness.
    harness: ?Harness = null,

    pub const json_field_names = .{
        .harness = "harness",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHarnessInput, options: CallOptions) !UpdateHarnessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHarnessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/harnesses/");
    try path_buf.appendSlice(allocator, input.harness_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_tools) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowedTools\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.authorizer_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_artifact) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentArtifact\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_iterations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxIterations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_tokens) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxTokens\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.memory) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"memory\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.model) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"model\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.skills) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"skills\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.system_prompt) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"systemPrompt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeoutSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tools) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tools\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.truncation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"truncation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHarnessOutput {
    var result: UpdateHarnessOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateHarnessOutput, body, allocator);
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
