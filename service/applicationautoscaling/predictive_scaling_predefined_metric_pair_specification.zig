/// Represents a metric pair for a predictive scaling policy.
///
/// The following predefined metrics are available for predictive scaling:
///
/// * `ECSServiceAverageCPUUtilization`
///
/// * `ECSServiceAverageMemoryUtilization`
///
/// * `ECSServiceCPUUtilization`
///
/// * `ECSServiceMemoryUtilization`
///
/// * `ECSServiceTotalCPUUtilization`
///
/// * `ECSServiceTotalMemoryUtilization`
///
/// * `ALBRequestCount`
///
/// * `ALBRequestCountPerTarget`
///
/// * `TotalALBRequestCount`
pub const PredictiveScalingPredefinedMetricPairSpecification = struct {
    /// Indicates which metrics to use. There are two different types of metrics for
    /// each
    /// metric type: one is a load metric and one is a scaling metric.
    predefined_metric_type: []const u8,

    /// A label that uniquely identifies a specific target group from which to
    /// determine
    /// the total and average request count.
    resource_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .predefined_metric_type = "PredefinedMetricType",
        .resource_label = "ResourceLabel",
    };
};
