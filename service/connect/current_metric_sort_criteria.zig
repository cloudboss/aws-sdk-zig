const CurrentMetricName = @import("current_metric_name.zig").CurrentMetricName;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The way to sort the resulting response based on metrics. By default
/// resources are sorted based on
/// `AGENTS_ONLINE`, `DESCENDING`. The metric collection is sorted based on the
/// input
/// metrics.
pub const CurrentMetricSortCriteria = struct {
    sort_by_metric: ?CurrentMetricName = null,

    /// The way to sort.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .sort_by_metric = "SortByMetric",
        .sort_order = "SortOrder",
    };
};
