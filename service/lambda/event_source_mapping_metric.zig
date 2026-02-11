pub const EventSourceMappingMetric = enum {
    event_count,
    error_count,
    kafka_metrics,

    pub const json_field_names = .{
        .event_count = "EventCount",
        .error_count = "ErrorCount",
        .kafka_metrics = "KafkaMetrics",
    };
};
