/// This structure defines a metric that is being used to evaluate the
/// variations during a launch or experiment.
pub const MetricDefinition = struct {
    /// The entity, such as a user or session, that does an action that causes a
    /// metric value to be recorded.
    entity_id_key: ?[]const u8 = null,

    /// The EventBridge event pattern that defines how the metric is recorded.
    ///
    /// For more information about EventBridge event patterns, see [Amazon
    /// EventBridge event
    /// patterns](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-patterns.html).
    event_pattern: ?[]const u8 = null,

    /// The name of the metric.
    name: ?[]const u8 = null,

    /// The label for the units that the metric is measuring.
    unit_label: ?[]const u8 = null,

    /// The value that is tracked to produce the metric.
    value_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .entity_id_key = "entityIdKey",
        .event_pattern = "eventPattern",
        .name = "name",
        .unit_label = "unitLabel",
        .value_key = "valueKey",
    };
};
