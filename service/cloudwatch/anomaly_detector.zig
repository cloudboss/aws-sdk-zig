const AnomalyDetectorConfiguration = @import("anomaly_detector_configuration.zig").AnomalyDetectorConfiguration;
const Dimension = @import("dimension.zig").Dimension;
const MetricCharacteristics = @import("metric_characteristics.zig").MetricCharacteristics;
const MetricMathAnomalyDetector = @import("metric_math_anomaly_detector.zig").MetricMathAnomalyDetector;
const SingleMetricAnomalyDetector = @import("single_metric_anomaly_detector.zig").SingleMetricAnomalyDetector;
const AnomalyDetectorStateValue = @import("anomaly_detector_state_value.zig").AnomalyDetectorStateValue;

/// An anomaly detection model associated with a particular CloudWatch metric,
/// statistic,
/// or metric math expression. You can use the model to display a band of
/// expected, normal
/// values when the metric is graphed.
///
/// If you have enabled unified cross-account observability, and this account is
/// a
/// monitoring account, the metric can be in the same account or a source
/// account.
pub const AnomalyDetector = struct {
    /// The configuration specifies details about how the anomaly detection model is
    /// to be
    /// trained, including time ranges to exclude from use for training the model,
    /// and the time
    /// zone to use for the metric.
    configuration: ?AnomalyDetectorConfiguration,

    /// The metric dimensions associated with the anomaly detection model.
    dimensions: ?[]const Dimension,

    /// This object includes parameters that you can use to provide information
    /// about your
    /// metric to CloudWatch to help it build more accurate anomaly detection
    /// models.
    /// Currently, it includes the `PeriodicSpikes` parameter.
    metric_characteristics: ?MetricCharacteristics,

    /// The CloudWatch metric math expression for this anomaly detector.
    metric_math_anomaly_detector: ?MetricMathAnomalyDetector,

    /// The name of the metric associated with the anomaly detection model.
    metric_name: ?[]const u8,

    /// The namespace of the metric associated with the anomaly detection model.
    namespace: ?[]const u8,

    /// The CloudWatch metric and statistic for this anomaly detector.
    single_metric_anomaly_detector: ?SingleMetricAnomalyDetector,

    /// The statistic associated with the anomaly detection model.
    stat: ?[]const u8,

    /// The current status of the anomaly detector's training.
    state_value: ?AnomalyDetectorStateValue,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .dimensions = "Dimensions",
        .metric_characteristics = "MetricCharacteristics",
        .metric_math_anomaly_detector = "MetricMathAnomalyDetector",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .single_metric_anomaly_detector = "SingleMetricAnomalyDetector",
        .stat = "Stat",
        .state_value = "StateValue",
    };
};
