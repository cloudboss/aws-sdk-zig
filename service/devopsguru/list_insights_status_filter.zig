const ListInsightsAnyStatusFilter = @import("list_insights_any_status_filter.zig").ListInsightsAnyStatusFilter;
const ListInsightsClosedStatusFilter = @import("list_insights_closed_status_filter.zig").ListInsightsClosedStatusFilter;
const ListInsightsOngoingStatusFilter = @import("list_insights_ongoing_status_filter.zig").ListInsightsOngoingStatusFilter;

/// A filter used by `ListInsights` to specify which insights to return.
pub const ListInsightsStatusFilter = struct {
    /// A `ListInsightsAnyStatusFilter` that specifies insights of any status that
    /// are either `REACTIVE` or `PROACTIVE`.
    any: ?ListInsightsAnyStatusFilter,

    /// A `ListInsightsClosedStatusFilter` that specifies closed insights that are
    /// either `REACTIVE` or `PROACTIVE`.
    closed: ?ListInsightsClosedStatusFilter,

    /// A `ListInsightsAnyStatusFilter` that specifies ongoing insights that are
    /// either `REACTIVE` or `PROACTIVE`.
    ongoing: ?ListInsightsOngoingStatusFilter,

    pub const json_field_names = .{
        .any = "Any",
        .closed = "Closed",
        .ongoing = "Ongoing",
    };
};
