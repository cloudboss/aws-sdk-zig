const EvaluationFormMetricType = @import("evaluation_form_metric_type.zig").EvaluationFormMetricType;

/// Information about the metric configuration for an evaluation form question.
/// Use this to associate a
/// business outcome metric with a question.
pub const EvaluationFormMetricConfiguration = struct {
    /// The name of the metric. Valid values are:
    ///
    /// * `SALE_SUCCESS` – Sale success.
    ///
    /// * `CSAT` – Customer satisfaction.
    ///
    /// * `CHURN_PROPENSITY` – Churn propensity.
    ///
    /// * `SELF_SERVICE_SUCCESS` – Self-service success.
    ///
    /// * `PARTIAL_SELF_SERVICE_SUCCESS` – Partial self-service success.
    metric_name: []const u8,

    /// The type of metric. Currently, only `BUSINESS_OUTCOME` is supported.
    metric_type: EvaluationFormMetricType,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .metric_type = "MetricType",
    };
};
