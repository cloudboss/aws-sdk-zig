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
    /// The agent's response to the user prompt.
    completion: ?ResponseStream = null,

    /// The MIME type of the input data in the request. The default value is
    /// `application/json`.
    content_type: []const u8,

    /// The unique identifier of the agent memory.
    memory_id: ?[]const u8 = null,

    /// The unique identifier of the session with the agent.
    session_id: []const u8,

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
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
