const MetricPublishFrequencyInSeconds = @import("metric_publish_frequency_in_seconds.zig").MetricPublishFrequencyInSeconds;

/// The configuration for Utilization metrics.
pub const MetricsConfig = struct {
    /// Specifies whether to enable enhanced metrics for the endpoint. Enhanced
    /// metrics provide utilization data at instance and container granularity.
    /// Container granularity is supported for Inference Components. The default is
    /// `False`.
    enable_enhanced_metrics: ?bool = null,

    /// The frequency, in seconds, at which utilization metrics are published to
    /// Amazon CloudWatch. The default is `60` seconds.
    metric_publish_frequency_in_seconds: ?MetricPublishFrequencyInSeconds = null,

    pub const json_field_names = .{
        .enable_enhanced_metrics = "EnableEnhancedMetrics",
        .metric_publish_frequency_in_seconds = "MetricPublishFrequencyInSeconds",
    };
};
