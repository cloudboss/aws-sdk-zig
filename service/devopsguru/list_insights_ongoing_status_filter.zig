const InsightType = @import("insight_type.zig").InsightType;

/// Used to filter for insights that have the status `ONGOING`.
pub const ListInsightsOngoingStatusFilter = struct {
    /// Use to filter for either `REACTIVE` or `PROACTIVE` insights.
    type: InsightType,

    pub const json_field_names = .{
        .type = "Type",
    };
};
