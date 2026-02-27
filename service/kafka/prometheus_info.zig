const JmxExporterInfo = @import("jmx_exporter_info.zig").JmxExporterInfo;
const NodeExporterInfo = @import("node_exporter_info.zig").NodeExporterInfo;

/// Prometheus settings.
pub const PrometheusInfo = struct {
    /// Indicates whether you want to turn on or turn off the JMX Exporter.
    jmx_exporter: ?JmxExporterInfo,

    /// Indicates whether you want to turn on or turn off the Node Exporter.
    node_exporter: ?NodeExporterInfo,

    pub const json_field_names = .{
        .jmx_exporter = "JmxExporter",
        .node_exporter = "NodeExporter",
    };
};
