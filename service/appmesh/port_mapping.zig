const PortProtocol = @import("port_protocol.zig").PortProtocol;

/// An object that represents a port mapping.
pub const PortMapping = struct {
    /// The port used for the port mapping.
    port: i32,

    /// The protocol used for the port mapping. Specify one protocol.
    protocol: PortProtocol,

    pub const json_field_names = .{
        .port = "port",
        .protocol = "protocol",
    };
};
