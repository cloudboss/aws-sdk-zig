const PortRange = @import("port_range.zig").PortRange;

/// Specifies which ports are accessible on a MicroVM. Only one of the port
/// specification options can be set.
pub const PortSpecification = union(enum) {
    /// Indicates that all ports are accessible.
    all_ports: ?struct {},
    /// A single port number.
    port: ?i32,
    /// A range of ports.
    range: ?PortRange,

    pub const json_field_names = .{
        .all_ports = "allPorts",
        .port = "port",
        .range = "range",
    };
};
