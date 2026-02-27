pub const PostContactSummaryFailureCode = enum {
    quota_exceeded,
    insufficient_conversation_content,
    failed_safety_guidelines,
    invalid_analysis_configuration,
    internal_error,

    pub const json_field_names = .{
        .quota_exceeded = "QUOTA_EXCEEDED",
        .insufficient_conversation_content = "INSUFFICIENT_CONVERSATION_CONTENT",
        .failed_safety_guidelines = "FAILED_SAFETY_GUIDELINES",
        .invalid_analysis_configuration = "INVALID_ANALYSIS_CONFIGURATION",
        .internal_error = "INTERNAL_ERROR",
    };
};
