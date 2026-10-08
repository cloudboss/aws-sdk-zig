const StartTimeRange = @import("start_time_range.zig").StartTimeRange;
const InsightType = @import("insight_type.zig").InsightType;

/// Used to filter for insights that have any status.
pub const ListInsightsAnyStatusFilter = struct {
    /// A time range used to specify when the behavior of the filtered insights
    /// started.
    start_time_range: StartTimeRange,

    /// Use to filter for either `REACTIVE` or `PROACTIVE` insights.
    type: InsightType,

    pub const json_field_names = .{
        .start_time_range = "StartTimeRange",
        .type = "Type",
    };
};
