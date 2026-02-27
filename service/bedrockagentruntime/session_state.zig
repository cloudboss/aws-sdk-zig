const aws = @import("aws");

const ConversationHistory = @import("conversation_history.zig").ConversationHistory;
const InputFile = @import("input_file.zig").InputFile;
const KnowledgeBaseConfiguration = @import("knowledge_base_configuration.zig").KnowledgeBaseConfiguration;
const InvocationResultMember = @import("invocation_result_member.zig").InvocationResultMember;

/// Contains parameters that specify various attributes that persist across a
/// session or prompt. You can define session state attributes as key-value
/// pairs when writing a [Lambda
/// function](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-lambda.html) for an action group or pass them when making an [InvokeAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html) request. Use session state attributes to control and provide conversational context for your agent and to help customize your agent's behavior. For more information, see [Control session context](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-session-state.html).
pub const SessionState = struct {
    /// The state's conversation history.
    conversation_history: ?ConversationHistory,

    /// Contains information about the files used by code interpreter.
    files: ?[]const InputFile,

    /// The identifier of the invocation of an action. This value must match the
    /// `invocationId` returned in the `InvokeAgent` response for the action whose
    /// results are provided in the `returnControlInvocationResults` field. For more
    /// information, see [Return control to the agent
    /// developer](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-returncontrol.html) and [Control session context](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-session-state.html).
    invocation_id: ?[]const u8,

    /// An array of configurations, each of which applies to a knowledge base
    /// attached to the agent.
    knowledge_base_configurations: ?[]const KnowledgeBaseConfiguration,

    /// Contains attributes that persist across a prompt and the values of those
    /// attributes.
    ///
    /// * In orchestration prompt template, these attributes replace the
    ///   $prompt_session_attributes$ placeholder variable. For more information,
    ///   see [Prompt template placeholder
    ///   variables](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-placeholders.html).
    /// * In [multi-agent
    ///   collaboration](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-multi-agent-collaboration.html), the `promptSessionAttributes` will only be used by supervisor agent when $prompt_session_attributes$ is present in prompt template.
    prompt_session_attributes: ?[]const aws.map.StringMapEntry,

    /// Contains information about the results from the action group invocation. For
    /// more information, see [Return control to the agent
    /// developer](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-returncontrol.html) and [Control session context](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-session-state.html).
    ///
    /// If you include this field, the `inputText` field will be ignored.
    return_control_invocation_results: ?[]const InvocationResultMember,

    /// Contains attributes that persist across a session and the values of those
    /// attributes. If `sessionAttributes` are passed to a supervisor agent in
    /// [multi-agent
    /// collaboration](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-multi-agent-collaboration.html), it will be forwarded to all agent collaborators.
    session_attributes: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .conversation_history = "conversationHistory",
        .files = "files",
        .invocation_id = "invocationId",
        .knowledge_base_configurations = "knowledgeBaseConfigurations",
        .prompt_session_attributes = "promptSessionAttributes",
        .return_control_invocation_results = "returnControlInvocationResults",
        .session_attributes = "sessionAttributes",
    };
};
