const Prometheus = @import("prometheus.zig").Prometheus;

/// JMX and Node monitoring for the MSK cluster.
pub const OpenMonitoring = struct {
    /// Prometheus settings.
    prometheus: Prometheus,

    pub const json_field_names = .{
        .prometheus = "Prometheus",
    };
};
