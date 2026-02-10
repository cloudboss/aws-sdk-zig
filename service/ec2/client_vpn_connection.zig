const ClientVpnConnectionStatus = @import("client_vpn_connection_status.zig").ClientVpnConnectionStatus;

/// Describes a client connection.
pub const ClientVpnConnection = struct {
    /// The IP address of the client.
    client_ip: ?[]const u8,

    /// The IPv6 address assigned to the client connection when using a dual-stack
    /// Client VPN endpoint. This field is only populated when the endpoint is
    /// configured for dual-stack addressing, and the client is using IPv6 for
    /// connectivity.
    client_ipv_6_address: ?[]const u8,

    /// The ID of the Client VPN endpoint to which the client is connected.
    client_vpn_endpoint_id: ?[]const u8,

    /// The common name associated with the client. This is either the name of the
    /// client certificate,
    /// or the Active Directory user name.
    common_name: ?[]const u8,

    /// The date and time the client connection was terminated.
    connection_end_time: ?[]const u8,

    /// The date and time the client connection was established.
    connection_established_time: ?[]const u8,

    /// The ID of the client connection.
    connection_id: ?[]const u8,

    /// The number of bytes received by the client.
    egress_bytes: ?[]const u8,

    /// The number of packets received by the client.
    egress_packets: ?[]const u8,

    /// The number of bytes sent by the client.
    ingress_bytes: ?[]const u8,

    /// The number of packets sent by the client.
    ingress_packets: ?[]const u8,

    /// The statuses returned by the client connect handler for posture compliance,
    /// if applicable.
    posture_compliance_statuses: ?[]const []const u8,

    /// The current state of the client connection.
    status: ?ClientVpnConnectionStatus,

    /// The current date and time.
    timestamp: ?[]const u8,

    /// The username of the client who established the client connection. This
    /// information is only provided
    /// if Active Directory client authentication is used.
    username: ?[]const u8,
};
