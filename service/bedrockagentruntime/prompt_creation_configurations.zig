/// Specifies parameters that control how the service populates the agent prompt
/// for an `InvokeAgent` or `InvokeInlineAgent` request. You can control which
/// aspects of previous invocations in the same agent session the service uses
/// to populate the agent prompt. This gives you more granular control over the
/// contextual history that is used to process the current request.
pub const PromptCreationConfigurations = struct {
    /// If `true`, the service removes any content between `<thinking>` tags from
    /// previous conversations in an agent session. The service will only remove
    /// content from already processed turns. This helps you remove content which
    /// might not be useful for current and subsequent invocations. This can reduce
    /// the input token count and potentially save costs. The default value is
    /// `false`.
    exclude_previous_thinking_steps: bool = false,

    /// The number of previous conversations from the ongoing agent session to
    /// include in the conversation history of the agent prompt, during the current
    /// invocation. This gives you more granular control over the context that the
    /// model is made aware of, and helps the model remove older context which is no
    /// longer useful during the ongoing agent session.
    previous_conversation_turns_to_include: ?i32 = null,

    pub const json_field_names = .{
        .exclude_previous_thinking_steps = "excludePreviousThinkingSteps",
        .previous_conversation_turns_to_include = "previousConversationTurnsToInclude",
    };
};
