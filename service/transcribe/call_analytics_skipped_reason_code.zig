pub const CallAnalyticsSkippedReasonCode = enum {
    insufficient_conversation_content,
    failed_safety_guidelines,

    pub const json_field_names = .{
        .insufficient_conversation_content = "INSUFFICIENT_CONVERSATION_CONTENT",
        .failed_safety_guidelines = "FAILED_SAFETY_GUIDELINES",
    };
};
