const SentimentType = @import("sentiment_type.zig").SentimentType;

/// A structure that contains the configuration settings for a sentiment
/// analysis task.
pub const SentimentConfiguration = struct {
    /// The name of the rule in the sentiment configuration.
    rule_name: []const u8,

    /// The type of sentiment, `POSITIVE`, `NEGATIVE`, or `NEUTRAL`.
    sentiment_type: SentimentType,

    /// Specifies the analysis interval.
    time_period: i32,

    pub const json_field_names = .{
        .rule_name = "RuleName",
        .sentiment_type = "SentimentType",
        .time_period = "TimePeriod",
    };
};
