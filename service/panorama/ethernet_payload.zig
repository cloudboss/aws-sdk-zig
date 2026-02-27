const ConnectionType = @import("connection_type.zig").ConnectionType;
const StaticIpConnectionInfo = @import("static_ip_connection_info.zig").StaticIpConnectionInfo;

/// A device's network configuration.
pub const EthernetPayload = struct {
    /// How the device gets an IP address.
    connection_type: ConnectionType,

    /// Network configuration for a static IP connection.
    static_ip_connection_info: ?StaticIpConnectionInfo,

    pub const json_field_names = .{
        .connection_type = "ConnectionType",
        .static_ip_connection_info = "StaticIpConnectionInfo",
    };
};
