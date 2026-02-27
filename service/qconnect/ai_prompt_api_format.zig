pub const AIPromptAPIFormat = enum {
    anthropic_claude_messages,
    anthropic_claude_text_completions,
    messages,
    text_completions,

    pub const json_field_names = .{
        .anthropic_claude_messages = "ANTHROPIC_CLAUDE_MESSAGES",
        .anthropic_claude_text_completions = "ANTHROPIC_CLAUDE_TEXT_COMPLETIONS",
        .messages = "MESSAGES",
        .text_completions = "TEXT_COMPLETIONS",
    };
};
