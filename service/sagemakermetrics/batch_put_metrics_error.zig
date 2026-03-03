const PutMetricsErrorCode = @import("put_metrics_error_code.zig").PutMetricsErrorCode;

/// An error that occured when putting the metric data.
pub const BatchPutMetricsError = struct {
    /// The error code of an error that occured when attempting to put metrics.
    ///
    /// * `METRIC_LIMIT_EXCEEDED`: The maximum amount of metrics per resource is
    /// exceeded.
    ///
    /// * `INTERNAL_ERROR`: An internal error occured.
    ///
    /// * `VALIDATION_ERROR`: The metric data failed validation.
    ///
    /// * `CONFLICT_ERROR`: Multiple requests attempted to modify the same data
    /// simultaneously.
    code: ?PutMetricsErrorCode = null,

    /// An index that corresponds to the metric in the request.
    metric_index: ?i32 = null,

    pub const json_field_names = .{
        .code = "Code",
        .metric_index = "MetricIndex",
    };
};
