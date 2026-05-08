const MetricPublishFrequencyInSeconds = @import("metric_publish_frequency_in_seconds.zig").MetricPublishFrequencyInSeconds;

/// The configuration for Utilization metrics.
pub const MetricsConfig = struct {
    /// Specifies whether to enable enhanced metrics for the endpoint. Enhanced
    /// metrics provide utilization and invocation data at instance and container
    /// granularity. Container granularity is supported for Inference Components.
    /// The default is `False`.
    enable_enhanced_metrics: ?bool = null,

    /// The interval, in seconds, at which metrics are published to Amazon
    /// CloudWatch. Defaults to `60`. Valid values: `10`, `30`, `60`, `120`, `180`,
    /// `240`, `300`. When `EnableEnhancedMetrics` is set to `False`, this interval
    /// applies to utilization metrics only; invocation metrics continue to be
    /// published at the default 60-second interval. When `EnableEnhancedMetrics` is
    /// set to `True`, this interval applies to both utilization and invocation
    /// metrics.
    metric_publish_frequency_in_seconds: ?MetricPublishFrequencyInSeconds = null,

    pub const json_field_names = .{
        .enable_enhanced_metrics = "EnableEnhancedMetrics",
        .metric_publish_frequency_in_seconds = "MetricPublishFrequencyInSeconds",
    };
};
