const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BedrockModelConfigurations = @import("bedrock_model_configurations.zig").BedrockModelConfigurations;
const PromptCreationConfigurations = @import("prompt_creation_configurations.zig").PromptCreationConfigurations;
const SessionState = @import("session_state.zig").SessionState;
const StreamingConfigurations = @import("streaming_configurations.zig").StreamingConfigurations;
const ResponseStream = @import("response_stream.zig").ResponseStream;

pub const InvokeAgentInput = struct {
    /// The alias of the agent to use.
    agent_alias_id: []const u8,

    /// The unique identifier of the agent to use.
    agent_id: []const u8,

    /// Model performance settings for the request.
    bedrock_model_configurations: ?BedrockModelConfigurations = null,

    /// Specifies whether to turn on the trace or not to track the agent's reasoning
    /// process. For more information, see [Trace
    /// enablement](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-test.html#trace-events).
    enable_trace: ?bool = null,

    /// Specifies whether to end the session with the agent or not.
    end_session: ?bool = null,

    /// The prompt text to send the agent.
    ///
    /// If you include `returnControlInvocationResults` in the `sessionState` field,
    /// the `inputText` field will be ignored.
    input_text: ?[]const u8 = null,

    /// The unique identifier of the agent memory.
    memory_id: ?[]const u8 = null,

    /// Specifies parameters that control how the service populates the agent prompt
    /// for an `InvokeAgent` request. You can control which aspects of previous
    /// invocations in the same agent session the service uses to populate the agent
    /// prompt. This gives you more granular control over the contextual history
    /// that is used to process the current request.
    prompt_creation_configurations: ?PromptCreationConfigurations = null,

    /// The unique identifier of the session. Use the same value across requests to
    /// continue the same conversation.
    session_id: []const u8,

    /// Contains parameters that specify various attributes of the session. For more
    /// information, see [Control session
    /// context](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-session-state.html).
    ///
    /// If you include `returnControlInvocationResults` in the `sessionState` field,
    /// the `inputText` field will be ignored.
    session_state: ?SessionState = null,

    /// The ARN of the resource making the request.
    source_arn: ?[]const u8 = null,

    /// Specifies the configurations for streaming.
    ///
    /// To use agent streaming, you need permissions to perform the
    /// `bedrock:InvokeModelWithResponseStream` action.
    streaming_configurations: ?StreamingConfigurations = null,

    pub const json_field_names = .{
        .agent_alias_id = "agentAliasId",
        .agent_id = "agentId",
        .bedrock_model_configurations = "bedrockModelConfigurations",
        .enable_trace = "enableTrace",
        .end_session = "endSession",
        .input_text = "inputText",
        .memory_id = "memoryId",
        .prompt_creation_configurations = "promptCreationConfigurations",
        .session_id = "sessionId",
        .session_state = "sessionState",
        .source_arn = "sourceArn",
        .streaming_configurations = "streamingConfigurations",
    };
};

pub const InvokeAgentOutput = struct {
    /// The MIME type of the input data in the request. The default value is
    /// `application/json`.
    content_type: []const u8,

    /// The unique identifier of the agent memory.
    memory_id: ?[]const u8 = null,

    /// The unique identifier of the session with the agent.
    session_id: []const u8,

    event_reader: aws.event_stream_reader.EventStreamReader = undefined,
    _stream_body: aws.http.StreamingBody = undefined,

    pub fn deinit(self: *InvokeAgentOutput) void {
        self.event_reader.deinit();
        self._stream_body.deinit();
    }

    pub const json_field_names = .{
        .completion = "completion",
        .content_type = "contentType",
        .memory_id = "memoryId",
        .session_id = "sessionId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeAgentInput, options: Options) !InvokeAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockagentruntime");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    stream_resp.deinitHeaders();
    errdefer stream_resp.body.deinit();

    const event_reader = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body.reader());
    return .{ .event_reader = event_reader, ._stream_body = stream_resp.body };
}

fn serializeRequest(alloc: std.mem.Allocator, input: InvokeAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagentruntime", "Bedrock Agent Runtime", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/agents/");
    try path_buf.appendSlice(alloc, input.agent_id);
    try path_buf.appendSlice(alloc, "/agentAliases/");
    try path_buf.appendSlice(alloc, input.agent_alias_id);
    try path_buf.appendSlice(alloc, "/sessions/");
    try path_buf.appendSlice(alloc, input.session_id);
    try path_buf.appendSlice(alloc, "/text");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.bedrock_model_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"bedrockModelConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable_trace) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"enableTrace\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.end_session) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"endSession\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.input_text) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"inputText\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.memory_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"memoryId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.prompt_creation_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"promptCreationConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.session_state) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"sessionState\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.streaming_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"streamingConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.source_arn) |v| {
        try request.headers.put(alloc, "x-amz-source-arn", v);
    }

    return request;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
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
    if (std.mem.eql(u8, error_code, "DependencyFailedException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "ModelNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .model_not_ready_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
