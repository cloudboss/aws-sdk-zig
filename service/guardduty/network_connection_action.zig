const LocalIpDetails = @import("local_ip_details.zig").LocalIpDetails;
const LocalPortDetails = @import("local_port_details.zig").LocalPortDetails;
const RemoteIpDetails = @import("remote_ip_details.zig").RemoteIpDetails;
const RemotePortDetails = @import("remote_port_details.zig").RemotePortDetails;

/// Contains information about the NETWORK_CONNECTION action described in the
/// finding.
pub const NetworkConnectionAction = struct {
    /// Indicates whether EC2 blocked the network connection to your instance.
    blocked: ?bool,

    /// The network connection direction.
    connection_direction: ?[]const u8,

    /// The local IP information of the connection.
    local_ip_details: ?LocalIpDetails,

    /// The EC2 instance's local elastic network interface utilized for the
    /// connection.
    local_network_interface: ?[]const u8,

    /// The local port information of the connection.
    local_port_details: ?LocalPortDetails,

    /// The network connection protocol.
    protocol: ?[]const u8,

    /// The remote IP information of the connection.
    remote_ip_details: ?RemoteIpDetails,

    /// The remote port information of the connection.
    remote_port_details: ?RemotePortDetails,

    pub const json_field_names = .{
        .blocked = "Blocked",
        .connection_direction = "ConnectionDirection",
        .local_ip_details = "LocalIpDetails",
        .local_network_interface = "LocalNetworkInterface",
        .local_port_details = "LocalPortDetails",
        .protocol = "Protocol",
        .remote_ip_details = "RemoteIpDetails",
        .remote_port_details = "RemotePortDetails",
    };
};
