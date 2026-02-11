const EventSourceMappingMetric = @import("event_source_mapping_metric.zig").EventSourceMappingMetric;

/// The metrics configuration for your event source. Use this configuration
/// object to define which metrics you want your event source mapping to
/// produce.
pub const EventSourceMappingMetricsConfig = struct {
    /// The metrics you want your event source mapping to produce, including
    /// `EventCount`, `ErrorCount`, `KafkaMetrics`.
    ///
    /// * `EventCount` to receive metrics related to the number of events processed
    ///   by your event source mapping.
    /// * `ErrorCount` (Amazon MSK and self-managed Apache Kafka) to receive metrics
    ///   related to the number of errors in your event source mapping processing.
    /// * `KafkaMetrics` (Amazon MSK and self-managed Apache Kafka) to receive
    ///   metrics related to the Kafka consumers from your event source mapping.
    ///
    /// For more information about these metrics, see [ Event source mapping
    /// metrics](https://docs.aws.amazon.com/lambda/latest/dg/monitoring-metrics-types.html#event-source-mapping-metrics).
    metrics: ?[]const EventSourceMappingMetric,

    pub const json_field_names = .{
        .metrics = "Metrics",
    };
};
