/// A structure that defines one error caused by a
/// [BatchCreateRumMetricsDefinitions](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_BatchDeleteRumMetricsDefinitions.html) operation.
pub const BatchDeleteRumMetricDefinitionsError = struct {
    /// The error code.
    error_code: []const u8,

    /// The error message for this metric definition.
    error_message: []const u8,

    /// The ID of the metric definition that caused this error.
    metric_definition_id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .metric_definition_id = "MetricDefinitionId",
    };
};
