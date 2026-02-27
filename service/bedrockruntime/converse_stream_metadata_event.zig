const ConverseStreamMetrics = @import("converse_stream_metrics.zig").ConverseStreamMetrics;
const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;
const ServiceTier = @import("service_tier.zig").ServiceTier;
const ConverseStreamTrace = @import("converse_stream_trace.zig").ConverseStreamTrace;
const TokenUsage = @import("token_usage.zig").TokenUsage;

/// A conversation stream metadata event.
pub const ConverseStreamMetadataEvent = struct {
    /// The metrics for the conversation stream metadata event.
    metrics: ConverseStreamMetrics,

    /// Model performance configuration metadata for the conversation stream event.
    performance_config: ?PerformanceConfiguration,

    /// Specifies the processing tier configuration used for serving the request.
    service_tier: ?ServiceTier,

    /// The trace object in the response from
    /// [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html) that contains information about the guardrail behavior.
    trace: ?ConverseStreamTrace,

    /// Usage information for the conversation stream event.
    usage: TokenUsage,

    pub const json_field_names = .{
        .metrics = "metrics",
        .performance_config = "performanceConfig",
        .service_tier = "serviceTier",
        .trace = "trace",
        .usage = "usage",
    };
};
