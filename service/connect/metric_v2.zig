const MetricFilterV2 = @import("metric_filter_v2.zig").MetricFilterV2;
const ThresholdV2 = @import("threshold_v2.zig").ThresholdV2;

/// Contains information about the metric.
///
/// Only one of either the Name or MetricId is required.
pub const MetricV2 = struct {
    /// Contains the filters to be used when returning data.
    metric_filters: ?[]const MetricFilterV2,

    /// Historical metrics or custom metrics can be referenced via this field. This
    /// field is a valid Amazon Connect
    /// Arn or a UUID
    metric_id: ?[]const u8,

    /// The name of the metric.
    name: ?[]const u8,

    /// Contains information about the threshold for service level metrics.
    threshold: ?[]const ThresholdV2,

    pub const json_field_names = .{
        .metric_filters = "MetricFilters",
        .metric_id = "MetricId",
        .name = "Name",
        .threshold = "Threshold",
    };
};
