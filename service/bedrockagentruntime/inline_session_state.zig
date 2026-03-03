const aws = @import("aws");

const ConversationHistory = @import("conversation_history.zig").ConversationHistory;
const InputFile = @import("input_file.zig").InputFile;
const InvocationResultMember = @import("invocation_result_member.zig").InvocationResultMember;

/// Contains parameters that specify various attributes that persist across a
/// session or prompt. You can define session state attributes as key-value
/// pairs when writing a [Lambda
/// function](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-lambda.html) for an action group or pass them when making an `InvokeInlineAgent` request. Use session state attributes to control and provide conversational context for your inline agent and to help customize your agent's behavior. For more information, see [Control session context](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-session-state.html)
pub const InlineSessionState = struct {
    /// Contains the conversation history that persist across sessions.
    conversation_history: ?ConversationHistory = null,

    /// Contains information about the files used by code interpreter.
    files: ?[]const InputFile = null,

    /// The identifier of the invocation of an action. This value must match the
    /// `invocationId` returned in the `InvokeInlineAgent` response for the action
    /// whose results are provided in the `returnControlInvocationResults` field.
    /// For more information, see [Return control to the agent
    /// developer](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-returncontrol.html).
    invocation_id: ?[]const u8 = null,

    /// Contains attributes that persist across a session and the values of those
    /// attributes.
    prompt_session_attributes: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the results from the action group invocation. For
    /// more information, see [Return control to the agent
    /// developer](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-returncontrol.html).
    ///
    /// If you include this field in the `sessionState` field, the `inputText` field
    /// will be ignored.
    return_control_invocation_results: ?[]const InvocationResultMember = null,

    /// Contains attributes that persist across a session and the values of those
    /// attributes.
    session_attributes: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .conversation_history = "conversationHistory",
        .files = "files",
        .invocation_id = "invocationId",
        .prompt_session_attributes = "promptSessionAttributes",
        .return_control_invocation_results = "returnControlInvocationResults",
        .session_attributes = "sessionAttributes",
    };
};
