const EndTimeRange = @import("end_time_range.zig").EndTimeRange;
const InsightType = @import("insight_type.zig").InsightType;

/// Used to filter for insights that have the status `CLOSED`.
pub const ListInsightsClosedStatusFilter = struct {
    /// A time range used to specify when the behavior of the filtered insights
    /// ended.
    end_time_range: EndTimeRange,

    /// Use to filter for either `REACTIVE` or `PROACTIVE` insights.
    @"type": InsightType,

    pub const json_field_names = .{
        .end_time_range = "EndTimeRange",
        .@"type" = "Type",
    };
};
