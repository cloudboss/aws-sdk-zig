const TopicTimeGranularity = @import("topic_time_granularity.zig").TopicTimeGranularity;
const ComparisonMethodType = @import("comparison_method_type.zig").ComparisonMethodType;

/// The definition of a `TopicIRComparisonMethod`.
pub const TopicIRComparisonMethod = struct {
    /// The period for the `TopicIRComparisonMethod`.
    period: ?TopicTimeGranularity,

    /// The type for the `TopicIRComparisonMethod`.
    @"type": ?ComparisonMethodType,

    /// The window size for the `TopicIRComparisonMethod`.
    window_size: i32 = 0,

    pub const json_field_names = .{
        .period = "Period",
        .@"type" = "Type",
        .window_size = "WindowSize",
    };
};
