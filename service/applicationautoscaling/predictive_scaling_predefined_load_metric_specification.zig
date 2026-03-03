/// Describes a load metric for a predictive scaling policy.
///
/// When returned in the output of `DescribePolicies`, it indicates that a
/// predictive scaling policy uses individually specified load and scaling
/// metrics instead
/// of a metric pair.
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
pub const PredictiveScalingPredefinedLoadMetricSpecification = struct {
    /// The metric type.
    predefined_metric_type: []const u8,

    /// A label that uniquely identifies a target group.
    resource_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .predefined_metric_type = "PredefinedMetricType",
        .resource_label = "ResourceLabel",
    };
};
