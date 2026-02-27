const PerformanceInsightsReferenceMetric = @import("performance_insights_reference_metric.zig").PerformanceInsightsReferenceMetric;
const PerformanceInsightsReferenceScalar = @import("performance_insights_reference_scalar.zig").PerformanceInsightsReferenceScalar;

/// Reference scalar values and other metrics that DevOps Guru displays on a
/// graph in its
/// console along with the actual metrics it analyzed. Compare these reference
/// values to
/// your actual metrics to help you understand anomalous behavior that DevOps
/// Guru
/// detected.
pub const PerformanceInsightsReferenceComparisonValues = struct {
    /// A metric that DevOps Guru compares to actual metric values. This reference
    /// metric is used to
    /// determine if an actual metric should be considered anomalous.
    reference_metric: ?PerformanceInsightsReferenceMetric,

    /// A scalar value DevOps Guru for a metric that DevOps Guru compares to actual
    /// metric values. This
    /// reference value is used to determine if an actual metric value should be
    /// considered
    /// anomalous.
    reference_scalar: ?PerformanceInsightsReferenceScalar,

    pub const json_field_names = .{
        .reference_metric = "ReferenceMetric",
        .reference_scalar = "ReferenceScalar",
    };
};
