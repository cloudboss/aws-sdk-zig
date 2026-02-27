const ContactMetricName = @import("contact_metric_name.zig").ContactMetricName;

/// Contains the details of a metric to be retrieved for a contact. Use this
/// object to specify which
/// contact level metrics you want to include in your GetContactMetrics request.
pub const ContactMetricInfo = struct {
    /// The name of the metric to retrieve. Supported values are POSITION_IN_QUEUE
    /// (returns the contact's
    /// current position in the queue) and ESTIMATED_WAIT_TIME (returns the
    /// predicted wait time in seconds).
    name: ContactMetricName,

    pub const json_field_names = .{
        .name = "Name",
    };
};
