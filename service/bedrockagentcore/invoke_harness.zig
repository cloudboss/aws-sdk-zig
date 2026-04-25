const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HarnessMessage = @import("harness_message.zig").HarnessMessage;
const HarnessModelConfiguration = @import("harness_model_configuration.zig").HarnessModelConfiguration;
const HarnessSkill = @import("harness_skill.zig").HarnessSkill;
const HarnessSystemContentBlock = @import("harness_system_content_block.zig").HarnessSystemContentBlock;
const HarnessTool = @import("harness_tool.zig").HarnessTool;
const InvokeHarnessStreamOutput = @import("invoke_harness_stream_output.zig").InvokeHarnessStreamOutput;

pub const InvokeHarnessInput = struct {
    /// The actor ID for memory operations. Overrides the actor ID configured on the
    /// harness.
    actor_id: ?[]const u8 = null,

    /// The tools that the agent is allowed to use for this invocation. If
    /// specified, overrides the harness default.
    allowed_tools: ?[]const []const u8 = null,

    /// The ARN of the harness to invoke.
    harness_arn: []const u8,

    /// The maximum number of iterations the agent loop can execute. If specified,
    /// overrides the harness default.
    max_iterations: ?i32 = null,

    /// The maximum number of tokens the agent can generate per iteration. If
    /// specified, overrides the harness default.
    max_tokens: ?i32 = null,

    /// The messages to send to the agent.
    messages: []const HarnessMessage,

    /// The model configuration to use for this invocation. If specified, overrides
    /// the harness default.
    model: ?HarnessModelConfiguration = null,

    /// The session ID for the invocation. Use the same session ID across requests
    /// to continue a conversation.
    runtime_session_id: []const u8,

    /// The skills available to the agent for this invocation. If specified,
    /// overrides the harness default.
    skills: ?[]const HarnessSkill = null,

    /// The system prompt to use for this invocation. If specified, overrides the
    /// harness default.
    system_prompt: ?[]const HarnessSystemContentBlock = null,

    /// The maximum duration in seconds for the agent loop execution. If specified,
    /// overrides the harness default.
    timeout_seconds: ?i32 = null,

    /// The tools available to the agent for this invocation. If specified,
    /// overrides the harness default.
    tools: ?[]const HarnessTool = null,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .allowed_tools = "allowedTools",
        .harness_arn = "harnessArn",
        .max_iterations = "maxIterations",
        .max_tokens = "maxTokens",
        .messages = "messages",
        .model = "model",
        .runtime_session_id = "runtimeSessionId",
        .skills = "skills",
        .system_prompt = "systemPrompt",
        .timeout_seconds = "timeoutSeconds",
        .tools = "tools",
    };
};

pub const InvokeHarnessOutput = struct {

    stream: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeHarnessOutput) void {
        self.stream.deinit();
    }

    pub const json_field_names = .{
        .stream = "stream",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeHarnessInput, options: CallOptions) !InvokeHarnessOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock-agentcore");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, error_body, stream_resp.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    stream_resp.deinitHeaders();
    errdefer stream_resp.body.deinit();

    const stream = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body);
    return .{ .stream = stream };
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeHarnessInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/harnesses/invoke";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "harnessArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.harness_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.actor_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actorId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.allowed_tools) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowedTools\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"messages\":");
    try aws.json.writeValue(@TypeOf(input.messages), input.messages, allocator, &body_buf);
    has_prev = true;
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

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Runtime-Session-Id", input.runtime_session_id);

    return request;
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateIdException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_id_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
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
    if (std.mem.eql(u8, error_code, "RetryableConflictException")) {
        return .{ .arena = arena, .kind = .{ .retryable_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RuntimeClientError")) {
        return .{ .arena = arena, .kind = .{ .runtime_client_error = .{
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
