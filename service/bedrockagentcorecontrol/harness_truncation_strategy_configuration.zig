const HarnessSlidingWindowConfiguration = @import("harness_sliding_window_configuration.zig").HarnessSlidingWindowConfiguration;
const HarnessSummarizationConfiguration = @import("harness_summarization_configuration.zig").HarnessSummarizationConfiguration;

/// Strategy-specific truncation configuration.
pub const HarnessTruncationStrategyConfiguration = union(enum) {
    /// Configuration for sliding window truncation.
    sliding_window: ?HarnessSlidingWindowConfiguration,
    /// Configuration for summarization-based truncation.
    summarization: ?HarnessSummarizationConfiguration,

    pub const json_field_names = .{
        .sliding_window = "slidingWindow",
        .summarization = "summarization",
    };
};
