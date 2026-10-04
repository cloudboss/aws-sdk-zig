const Behavior = @import("behavior.zig").Behavior;

/// The sentiment configuration for conversational analytics.
pub const SentimentConfiguration = struct {
    /// Controls whether sentiment analysis is applied to the analytics output.
    /// Valid values: `Enable` |
    /// `Disable`.
    behavior: Behavior,

    pub const json_field_names = .{
        .behavior = "Behavior",
    };
};
