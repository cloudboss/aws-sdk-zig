/// Configuration for summarization-based truncation strategy.
pub const HarnessSummarizationConfiguration = struct {
    /// The number of recent messages to preserve without summarization.
    preserve_recent_messages: ?i32 = null,

    /// The system prompt used for generating summaries.
    summarization_system_prompt: ?[]const u8 = null,

    /// The ratio of content to summarize.
    summary_ratio: ?f32 = null,

    pub const json_field_names = .{
        .preserve_recent_messages = "preserveRecentMessages",
        .summarization_system_prompt = "summarizationSystemPrompt",
        .summary_ratio = "summaryRatio",
    };
};
