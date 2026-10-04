const MetricsEndpoint = @import("metrics_endpoint.zig").MetricsEndpoint;

/// The configuration for container-level metrics scraping. Use this
/// configuration to specify a custom metrics endpoint path and publishing
/// frequency for container metrics. When `EnableDetailedObservability` is set
/// to `True` in `MetricsConfig`, metrics are scraped from the container's
/// Prometheus endpoint. If this configuration is not provided, the default path
/// `/metrics` on port `8080` is used with a default publishing frequency of
/// `60` seconds. For first-party and Deep Learning Containers (DLC), the
/// endpoint path is determined automatically and this configuration is
/// optional.
pub const ContainerMetricsConfig = struct {
    /// A list of metrics endpoints to scrape from the container. Each endpoint
    /// specifies the path where the container exposes Prometheus-formatted metrics
    /// and the frequency at which to publish them. You can specify a maximum of 1
    /// endpoint.
    metrics_endpoints: ?[]const MetricsEndpoint = null,

    pub const json_field_names = .{
        .metrics_endpoints = "MetricsEndpoints",
    };
};
