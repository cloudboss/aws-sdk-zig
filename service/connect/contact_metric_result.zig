const ContactMetricName = @import("contact_metric_name.zig").ContactMetricName;
const ContactMetricValue = @import("contact_metric_value.zig").ContactMetricValue;

/// Contains the result of a requested metric for the contact. This object is
/// returned as part of the
/// GetContactMetrics response and includes both the metric name and its
/// calculated value.
pub const ContactMetricResult = struct {
    /// The name of the metric that was retrieved. This corresponds to the metric
    /// name specified in the
    /// request, such as POSITION_IN_QUEUE or ESTIMATED_WAIT_TIME.
    name: ContactMetricName,

    /// The calculated value for the requested metric. This object contains the
    /// numeric result based on
    /// the contact's current state in the queue.
    value: ContactMetricValue,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
