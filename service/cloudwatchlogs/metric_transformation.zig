const aws = @import("aws");

const StandardUnit = @import("standard_unit.zig").StandardUnit;

/// Indicates how to transform ingested log events to metric data in a
/// CloudWatch
/// metric.
pub const MetricTransformation = struct {
    /// (Optional) The value to emit when a filter pattern does not match a log
    /// event. This
    /// value can be null.
    default_value: ?f64,

    /// The fields to use as dimensions for the metric. One metric filter can
    /// include as many as
    /// three dimensions.
    ///
    /// Metrics extracted from log events are charged as custom metrics. To prevent
    /// unexpected
    /// high charges, do not specify high-cardinality fields such as `IPAddress` or
    /// `requestID` as dimensions. Each different value found for a dimension is
    /// treated as a separate metric and accrues charges as a separate custom
    /// metric.
    ///
    /// CloudWatch Logs disables a metric filter if it generates 1000 different
    /// name/value
    /// pairs for your specified dimensions within a certain amount of time. This
    /// helps to prevent
    /// accidental high charges.
    ///
    /// You can also set up a billing alarm to alert you if your charges are higher
    /// than
    /// expected. For more information, see [
    /// Creating a Billing Alarm to Monitor Your Estimated Amazon Web Services
    /// Charges](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html).
    dimensions: ?[]const aws.map.StringMapEntry,

    /// The name of the CloudWatch metric.
    metric_name: []const u8,

    /// A custom namespace to contain your metric in CloudWatch. Use namespaces to
    /// group
    /// together metrics that are similar. For more information, see
    /// [Namespaces](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Namespace).
    metric_namespace: []const u8,

    /// The value to publish to the CloudWatch metric when a filter pattern matches
    /// a log
    /// event.
    metric_value: []const u8,

    /// The unit to assign to the metric. If you omit this, the unit is set as
    /// `None`.
    unit: ?StandardUnit,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .dimensions = "dimensions",
        .metric_name = "metricName",
        .metric_namespace = "metricNamespace",
        .metric_value = "metricValue",
        .unit = "unit",
    };
};
