const JmxExporter = @import("jmx_exporter.zig").JmxExporter;
const NodeExporter = @import("node_exporter.zig").NodeExporter;

/// Prometheus settings.
pub const Prometheus = struct {
    /// Indicates whether you want to turn on or turn off the JMX Exporter.
    jmx_exporter: ?JmxExporter,

    /// Indicates whether you want to turn on or turn off the Node Exporter.
    node_exporter: ?NodeExporter,

    pub const json_field_names = .{
        .jmx_exporter = "JmxExporter",
        .node_exporter = "NodeExporter",
    };
};
