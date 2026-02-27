const NetworkConnectionStatus = @import("network_connection_status.zig").NetworkConnectionStatus;

/// A device's Ethernet status.
pub const EthernetStatus = struct {
    /// The device's connection status.
    connection_status: ?NetworkConnectionStatus,

    /// The device's physical address.
    hw_address: ?[]const u8,

    /// The device's IP address.
    ip_address: ?[]const u8,

    pub const json_field_names = .{
        .connection_status = "ConnectionStatus",
        .hw_address = "HwAddress",
        .ip_address = "IpAddress",
    };
};
