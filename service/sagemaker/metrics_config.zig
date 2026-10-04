const MetricPublishFrequencyInSeconds = @import("metric_publish_frequency_in_seconds.zig").MetricPublishFrequencyInSeconds;

/// The configuration for Utilization metrics.
pub const MetricsConfig = struct {
    /// Indicates whether detailed observability is enabled for the endpoint. When
    /// set to `True`, the following metrics are published at the configured
    /// frequency:
    ///
    /// * Container-level inference metrics scraped from the container's Prometheus
    ///   endpoint (such as request latency, error counts, and throughput).
    ///   Available metrics vary by framework.
    /// * Per-GPU metrics (utilization, memory, and temperature) attributed to
    ///   individual inference components.
    /// * Per-instance host metrics (CPU, memory, and disk utilization).
    /// * Inference component placement metrics (copy count per Availability Zone).
    ///
    /// For first-party and Deep Learning Containers (DLC), the Prometheus endpoint
    /// path is determined automatically. For Bring-Your-Own-Container (BYOC) cases,
    /// you can optionally set `ContainerMetricsConfig` to specify a custom endpoint
    /// path. If not specified, the default path `/metrics` on port `8080` is used.
    ///
    /// When set to `False`, these additional metrics are not published. Standard
    /// invocation and utilization metrics controlled by `EnableEnhancedMetrics` are
    /// unaffected.
    ///
    /// The default value for new endpoint configurations is `True`. For existing
    /// endpoint configurations created before this feature, the value is `False`
    /// unless explicitly set.
    enable_detailed_observability: ?bool = null,

    /// Specifies whether to enable enhanced metrics for the endpoint. Enhanced
    /// metrics provide utilization and invocation data at instance and container
    /// granularity. Container granularity is supported for Inference Components.
    /// The default is `False`.
    enable_enhanced_metrics: ?bool = null,

    /// The interval, in seconds, at which metrics are published to Amazon
    /// CloudWatch. Defaults to `60`. Valid values: `10`, `30`, `60`, `120`, `180`,
    /// `240`, `300`.
    ///
    /// When `EnableEnhancedMetrics` is set to `False`, this interval applies to
    /// utilization metrics only. Invocation metrics continue to be published at the
    /// default 60-second interval. When `EnableEnhancedMetrics` is set to `True`,
    /// this interval applies to both utilization and invocation metrics.
    ///
    /// When `EnableDetailedObservability` is set to `True`, this interval applies
    /// to per-GPU metrics, per-instance host metrics, container metrics, and
    /// fleet-level inference component lifecycle and placement metrics.
    metric_publish_frequency_in_seconds: ?MetricPublishFrequencyInSeconds = null,

    pub const json_field_names = .{
        .enable_detailed_observability = "EnableDetailedObservability",
        .enable_enhanced_metrics = "EnableEnhancedMetrics",
        .metric_publish_frequency_in_seconds = "MetricPublishFrequencyInSeconds",
    };
};
