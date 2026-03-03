const aws = @import("aws");

/// A structure that displays the definition of one extended metric that RUM
/// sends to CloudWatch or CloudWatch Evidently. For more information, see [
/// Additional metrics that you can send to CloudWatch and CloudWatch
/// Evidently](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-vended-metrics.html).
pub const MetricDefinition = struct {
    /// This field is a map of field paths to dimension names. It defines the
    /// dimensions to associate with this metric in CloudWatch The value of this
    /// field is used only if the metric destination is `CloudWatch`. If the metric
    /// destination is `Evidently`, the value of `DimensionKeys` is ignored.
    dimension_keys: ?[]const aws.map.StringMapEntry = null,

    /// The pattern that defines the metric. RUM checks events that happen in a
    /// user's session against the pattern, and events that match the pattern are
    /// sent to the metric destination.
    ///
    /// If the metrics destination is `CloudWatch` and the event also matches a
    /// value in `DimensionKeys`, then the metric is published with the specified
    /// dimensions.
    event_pattern: ?[]const u8 = null,

    /// The ID of this metric definition.
    metric_definition_id: []const u8,

    /// The name of the metric that is defined in this structure.
    name: []const u8,

    /// If this metric definition is for a custom metric instead of an extended
    /// metric, this field displays the metric namespace that the custom metric is
    /// published to.
    namespace: ?[]const u8 = null,

    /// Use this field only if you are sending this metric to CloudWatch. It defines
    /// the CloudWatch metric unit that this metric is measured in.
    unit_label: ?[]const u8 = null,

    /// The field within the event object that the metric value is sourced from.
    value_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .dimension_keys = "DimensionKeys",
        .event_pattern = "EventPattern",
        .metric_definition_id = "MetricDefinitionId",
        .name = "Name",
        .namespace = "Namespace",
        .unit_label = "UnitLabel",
        .value_key = "ValueKey",
    };
};
