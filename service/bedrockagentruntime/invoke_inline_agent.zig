const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AgentActionGroup = @import("agent_action_group.zig").AgentActionGroup;
const AgentCollaboration = @import("agent_collaboration.zig").AgentCollaboration;
const InlineBedrockModelConfigurations = @import("inline_bedrock_model_configurations.zig").InlineBedrockModelConfigurations;
const CollaboratorConfiguration = @import("collaborator_configuration.zig").CollaboratorConfiguration;
const Collaborator = @import("collaborator.zig").Collaborator;
const CustomOrchestration = @import("custom_orchestration.zig").CustomOrchestration;
const GuardrailConfigurationWithArn = @import("guardrail_configuration_with_arn.zig").GuardrailConfigurationWithArn;
const InlineSessionState = @import("inline_session_state.zig").InlineSessionState;
const KnowledgeBase = @import("knowledge_base.zig").KnowledgeBase;
const OrchestrationType = @import("orchestration_type.zig").OrchestrationType;
const PromptCreationConfigurations = @import("prompt_creation_configurations.zig").PromptCreationConfigurations;
const PromptOverrideConfiguration = @import("prompt_override_configuration.zig").PromptOverrideConfiguration;
const StreamingConfigurations = @import("streaming_configurations.zig").StreamingConfigurations;
const InlineAgentResponseStream = @import("inline_agent_response_stream.zig").InlineAgentResponseStream;

pub const InvokeInlineAgentInput = struct {
    /// A list of action groups with each action group defining the action the
    /// inline agent needs to carry out.
    action_groups: ?[]const AgentActionGroup = null,

    /// Defines how the inline collaborator agent handles information across
    /// multiple collaborator agents to coordinate a final response. The inline
    /// collaborator agent can also be the supervisor.
    agent_collaboration: ?AgentCollaboration = null,

    /// The name for the agent.
    agent_name: ?[]const u8 = null,

    /// Model settings for the request.
    bedrock_model_configurations: ?InlineBedrockModelConfigurations = null,

    /// Settings for an inline agent collaborator called with
    /// [InvokeInlineAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeInlineAgent.html).
    collaborator_configurations: ?[]const CollaboratorConfiguration = null,

    /// List of collaborator inline agents.
    collaborators: ?[]const Collaborator = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services KMS key to use to
    /// encrypt your inline agent.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// Contains details of the custom orchestration configured for the agent.
    custom_orchestration: ?CustomOrchestration = null,

    /// Specifies whether to turn on the trace or not to track the agent's reasoning
    /// process. For more information, see [Using
    /// trace](https://docs.aws.amazon.com/bedrock/latest/userguide/trace-events.html).
    enable_trace: ?bool = null,

    /// Specifies whether to end the session with the inline agent or not.
    end_session: ?bool = null,

    /// The [model identifier
    /// (ID)](https://docs.aws.amazon.com/bedrock/latest/userguide/model-ids.html#model-ids-arns) of the model to use for orchestration by the inline agent. For example, `meta.llama3-1-70b-instruct-v1:0`.
    foundation_model: []const u8,

    /// The
    /// [guardrails](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails.html) to assign to the inline agent.
    guardrail_configuration: ?GuardrailConfigurationWithArn = null,

    /// The number of seconds for which the inline agent should maintain session
    /// information. After this time expires, the subsequent `InvokeInlineAgent`
    /// request begins a new session.
    ///
    /// A user interaction remains active for the amount of time specified. If no
    /// conversation occurs during this time, the session expires and the data
    /// provided before the timeout is deleted.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// Parameters that specify the various attributes of a sessions. You can
    /// include attributes for the session or prompt or, if you configured an action
    /// group to return control, results from invocation of the action group. For
    /// more information, see [Control session
    /// context](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-session-state.html).
    ///
    /// If you include `returnControlInvocationResults` in the `sessionState` field,
    /// the `inputText` field will be ignored.
    inline_session_state: ?InlineSessionState = null,

    /// The prompt text to send to the agent.
    ///
    /// If you include `returnControlInvocationResults` in the `sessionState` field,
    /// the `inputText` field will be ignored.
    input_text: ?[]const u8 = null,

    /// The instructions that tell the inline agent what it should do and how it
    /// should interact with users.
    instruction: []const u8,

    /// Contains information of the knowledge bases to associate with.
    knowledge_bases: ?[]const KnowledgeBase = null,

    /// Specifies the type of orchestration strategy for the agent. This is set to
    /// DEFAULT orchestration type, by default.
    orchestration_type: ?OrchestrationType = null,

    /// Specifies parameters that control how the service populates the agent prompt
    /// for an `InvokeInlineAgent` request. You can control which aspects of
    /// previous invocations in the same agent session the service uses to populate
    /// the agent prompt. This gives you more granular control over the contextual
    /// history that is used to process the current request.
    prompt_creation_configurations: ?PromptCreationConfigurations = null,

    /// Configurations for advanced prompts used to override the default prompts to
    /// enhance the accuracy of the inline agent.
    prompt_override_configuration: ?PromptOverrideConfiguration = null,

    /// The unique identifier of the session. Use the same value across requests to
    /// continue the same conversation.
    session_id: []const u8,

    /// Specifies the configurations for streaming.
    ///
    /// To use agent streaming, you need permissions to perform the
    /// `bedrock:InvokeModelWithResponseStream` action.
    streaming_configurations: ?StreamingConfigurations = null,

    pub const json_field_names = .{
        .action_groups = "actionGroups",
        .agent_collaboration = "agentCollaboration",
        .agent_name = "agentName",
        .bedrock_model_configurations = "bedrockModelConfigurations",
        .collaborator_configurations = "collaboratorConfigurations",
        .collaborators = "collaborators",
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .custom_orchestration = "customOrchestration",
        .enable_trace = "enableTrace",
        .end_session = "endSession",
        .foundation_model = "foundationModel",
        .guardrail_configuration = "guardrailConfiguration",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .inline_session_state = "inlineSessionState",
        .input_text = "inputText",
        .instruction = "instruction",
        .knowledge_bases = "knowledgeBases",
        .orchestration_type = "orchestrationType",
        .prompt_creation_configurations = "promptCreationConfigurations",
        .prompt_override_configuration = "promptOverrideConfiguration",
        .session_id = "sessionId",
        .streaming_configurations = "streamingConfigurations",
    };
};

pub const InvokeInlineAgentOutput = struct {
    /// The MIME type of the input data in the request. The default value is
    /// application/json.
    content_type: []const u8,

    /// The unique identifier of the session with the agent.
    session_id: []const u8,

    completion: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeInlineAgentOutput) void {
        self.completion.deinit();
    }

    pub const json_field_names = .{
        .completion = "completion",
        .content_type = "contentType",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeInlineAgentInput, options: CallOptions) !InvokeInlineAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock");

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

    const completion = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body);
    return .{ .completion = completion };
}

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeInlineAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.session_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action_groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actionGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.agent_collaboration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"agentCollaboration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.agent_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"agentName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.bedrock_model_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"bedrockModelConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.collaborator_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"collaboratorConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.collaborators) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"collaborators\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.customer_encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customerEncryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_orchestration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customOrchestration\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"foundationModel\":");
    try aws.json.writeValue(@TypeOf(input.foundation_model), input.foundation_model, allocator, &body_buf);
    has_prev = true;
    if (input.guardrail_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"guardrailConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idle_session_ttl_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idleSessionTTLInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.inline_session_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inlineSessionState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_text) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inputText\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"instruction\":");
    try aws.json.writeValue(@TypeOf(input.instruction), input.instruction, allocator, &body_buf);
    has_prev = true;
    if (input.knowledge_bases) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"knowledgeBases\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.orchestration_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"orchestrationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prompt_creation_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"promptCreationConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prompt_override_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"promptOverrideConfiguration\":");
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

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
