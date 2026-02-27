const PrometheusInfo = @import("prometheus_info.zig").PrometheusInfo;

/// JMX and Node monitoring for the MSK cluster.
pub const OpenMonitoringInfo = struct {
    /// Prometheus settings.
    prometheus: PrometheusInfo,

    pub const json_field_names = .{
        .prometheus = "Prometheus",
    };
};
