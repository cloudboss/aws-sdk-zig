const MetricTransformation = @import("metric_transformation.zig").MetricTransformation;

/// Metric filters express how CloudWatch Logs would extract metric observations
/// from
/// ingested log events and transform them into metric data in a CloudWatch
/// metric.
pub const MetricFilter = struct {
    /// This parameter is valid only for log groups that have an active log
    /// transformer. For more
    /// information about log transformers, see
    /// [PutTransformer](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutTransformer.html).
    ///
    /// If this value is `true`, the metric filter is applied on the transformed
    /// version of the log events instead of the original ingested log events.
    apply_on_transformed_logs: bool = false,

    /// The creation time of the metric filter, expressed as the number of
    /// milliseconds after
    /// `Jan 1, 1970 00:00:00 UTC`.
    creation_time: ?i64 = null,

    /// The list of system fields that are emitted as additional dimensions in the
    /// generated
    /// metrics. Returns the `emitSystemFieldDimensions` value if it was specified
    /// when the
    /// metric filter was created.
    emit_system_field_dimensions: ?[]const []const u8 = null,

    /// The filter expression that specifies which log events are processed by this
    /// metric filter
    /// based on system fields. Returns the `fieldSelectionCriteria` value if it was
    /// specified when the metric filter was created.
    field_selection_criteria: ?[]const u8 = null,

    /// The name of the metric filter.
    filter_name: ?[]const u8 = null,

    filter_pattern: ?[]const u8 = null,

    /// The name of the log group.
    log_group_name: ?[]const u8 = null,

    /// The metric transformations.
    metric_transformations: ?[]const MetricTransformation = null,

    pub const json_field_names = .{
        .apply_on_transformed_logs = "applyOnTransformedLogs",
        .creation_time = "creationTime",
        .emit_system_field_dimensions = "emitSystemFieldDimensions",
        .field_selection_criteria = "fieldSelectionCriteria",
        .filter_name = "filterName",
        .filter_pattern = "filterPattern",
        .log_group_name = "logGroupName",
        .metric_transformations = "metricTransformations",
    };
};
