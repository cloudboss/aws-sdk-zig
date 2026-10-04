const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    completion: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeAgentOutput) void {
        self.completion.deinit();
    }

    pub const json_field_names = .{
        .completion = "completion",
        .content_type = "contentType",
        .memory_id = "memoryId",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeAgentInput, options: CallOptions) !InvokeAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentAliases/");
    try path_buf.appendSlice(allocator, input.agent_alias_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    try path_buf.appendSlice(allocator, "/text");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bedrock_model_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"bedrockModelConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enable_trace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableTrace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.end_session) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endSession\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inputText\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.memory_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"memoryId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prompt_creation_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"promptCreationConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.streaming_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"streamingConfigurations\":");
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
    if (input.source_arn) |v| {
        try request.headers.put(allocator, "x-amz-source-arn", v);
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !InvokeAgentOutput {
    var result: InvokeAgentOutput = .{
        .content_type = "",
        .session_id = "",
    };
    errdefer {
        allocator.free(result.content_type);
        if (result.memory_id) |value| allocator.free(value);
        allocator.free(result.session_id);
    }
    if (stream_resp.headers.get("x-amzn-bedrock-agent-content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-bedrock-agent-memory-id")) |value| {
        result.memory_id = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-bedrock-agent-session-id")) |value| {
        result.session_id = try allocator.dupe(u8, value);
    }
    result.completion = try aws.event_stream_reader.EventStreamReader.init(
        allocator,
        stream_resp.body,
    );
    stream_resp.deinitHeaders();

    return result;
}
