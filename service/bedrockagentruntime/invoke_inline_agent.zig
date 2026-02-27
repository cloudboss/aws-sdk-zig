const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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
    /// The inline agent's response to the user prompt.
    completion: ?InlineAgentResponseStream = null,

    /// The MIME type of the input data in the request. The default value is
    /// application/json.
    content_type: []const u8,

    /// The unique identifier of the session with the agent.
    session_id: []const u8,

    pub const json_field_names = .{
        .completion = "completion",
        .content_type = "contentType",
        .session_id = "sessionId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeInlineAgentInput, options: Options) !InvokeInlineAgentOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
