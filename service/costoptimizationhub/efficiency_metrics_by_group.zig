const MetricsByTime = @import("metrics_by_time.zig").MetricsByTime;

/// Contains cost efficiency metrics for a specific group over time. The group
/// is defined by the grouping dimension specified in the request, such as
/// account ID, Amazon Web Services Region.
pub const EfficiencyMetricsByGroup = struct {
    /// The value of the grouping dimension for this set of metrics. For example, if
    /// grouped by account ID, this field contains the account ID. If no grouping is
    /// specified, this field is empty.
    group: ?[]const u8,

    /// An explanation of why efficiency metrics could not be calculated for this
    /// group when the metricsByTime field is null. Common reasons include
    /// insufficient or inconclusive cost and usage data during the specified time
    /// period. This field is null or empty when metrics are successfully
    /// calculated.
    message: ?[]const u8,

    /// A list of time-series data points containing efficiency metrics for this
    /// group. Each data point includes an efficiency score, estimated savings,
    /// spending, and a timestamp corresponding to the specified granularity. This
    /// field is null when efficiency metrics cannot be calculated for the group, in
    /// which case the message field provides an explanation.
    metrics_by_time: ?[]const MetricsByTime,

    pub const json_field_names = .{
        .group = "group",
        .message = "message",
        .metrics_by_time = "metricsByTime",
    };
};
