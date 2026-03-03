const AnalyticsInterval = @import("analytics_interval.zig").AnalyticsInterval;
const AnalyticsBinByName = @import("analytics_bin_by_name.zig").AnalyticsBinByName;
const AnalyticsSortOrder = @import("analytics_sort_order.zig").AnalyticsSortOrder;

/// Contains the time metric, interval, and method by which to bin the analytics
/// data.
pub const AnalyticsBinBySpecification = struct {
    /// Specifies the interval of time by which to bin the analytics data.
    interval: AnalyticsInterval,

    /// Specifies the time metric by which to bin the analytics data.
    name: AnalyticsBinByName,

    /// Specifies whether to bin the analytics data in ascending or descending
    /// order. If this field is left blank, the default order is by the key of the
    /// bin in descending order.
    order: ?AnalyticsSortOrder = null,

    pub const json_field_names = .{
        .interval = "interval",
        .name = "name",
        .order = "order",
    };
};
