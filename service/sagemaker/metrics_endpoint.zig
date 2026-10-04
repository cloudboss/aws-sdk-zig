const MetricPublishFrequencyInSeconds = @import("metric_publish_frequency_in_seconds.zig").MetricPublishFrequencyInSeconds;

/// Specifies a metrics endpoint for a container, including the path where the
/// container exposes Prometheus-formatted metrics and the frequency at which to
/// publish them to Amazon CloudWatch.
pub const MetricsEndpoint = struct {
    /// The interval, in seconds, at which container metrics scraped from the
    /// endpoint are published to Amazon CloudWatch. Valid values: `10`, `30`, `60`,
    /// `120`, `180`, `240`, `300`. Defaults to `60`.
    metric_publish_frequency_in_seconds: ?MetricPublishFrequencyInSeconds = null,

    /// The path to the metrics endpoint exposed by the container. For example,
    /// `/metrics` or `/server/metrics`. The path must start with `/` and can
    /// contain alphanumeric characters, forward slashes, underscores, hyphens, and
    /// periods. Maximum length is 256 characters. If not specified, defaults to
    /// `/metrics`.
    metrics_endpoint_path: []const u8,

    pub const json_field_names = .{
        .metric_publish_frequency_in_seconds = "MetricPublishFrequencyInSeconds",
        .metrics_endpoint_path = "MetricsEndpointPath",
    };
};
