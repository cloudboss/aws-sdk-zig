const MetricDefinitionRequest = @import("metric_definition_request.zig").MetricDefinitionRequest;

/// A structure that defines one error caused by a
/// [BatchCreateRumMetricsDefinitions](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_BatchCreateRumMetricsDefinitions.html) operation.
pub const BatchCreateRumMetricDefinitionsError = struct {
    /// The error code.
    error_code: []const u8,

    /// The error message for this metric definition.
    error_message: []const u8,

    /// The metric definition that caused this error.
    metric_definition: MetricDefinitionRequest,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .metric_definition = "MetricDefinition",
    };
};
