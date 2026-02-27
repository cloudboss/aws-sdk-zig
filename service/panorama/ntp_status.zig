const NetworkConnectionStatus = @import("network_connection_status.zig").NetworkConnectionStatus;

/// Details about an NTP server connection.
pub const NtpStatus = struct {
    /// The connection's status.
    connection_status: ?NetworkConnectionStatus,

    /// The IP address of the server.
    ip_address: ?[]const u8,

    /// The domain name of the server.
    ntp_server_name: ?[]const u8,

    pub const json_field_names = .{
        .connection_status = "ConnectionStatus",
        .ip_address = "IpAddress",
        .ntp_server_name = "NtpServerName",
    };
};
