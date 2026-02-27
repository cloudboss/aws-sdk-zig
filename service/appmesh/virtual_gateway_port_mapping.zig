const VirtualGatewayPortProtocol = @import("virtual_gateway_port_protocol.zig").VirtualGatewayPortProtocol;

/// An object that represents a port mapping.
pub const VirtualGatewayPortMapping = struct {
    /// The port used for the port mapping. Specify one protocol.
    port: i32,

    /// The protocol used for the port mapping.
    protocol: VirtualGatewayPortProtocol,

    pub const json_field_names = .{
        .port = "port",
        .protocol = "protocol",
    };
};
