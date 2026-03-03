/// Defines connection tracking parameters for network interfaces.
pub const ConnectionTrackingSpecificationRequest = struct {
    /// Timeout for established TCP connections.
    tcp_established_timeout: ?i32 = null,

    /// Timeout for UDP stream connections.
    udp_stream_timeout: ?i32 = null,

    /// General timeout for UDP connections.
    udp_timeout: ?i32 = null,

    pub const json_field_names = .{
        .tcp_established_timeout = "TcpEstablishedTimeout",
        .udp_stream_timeout = "UdpStreamTimeout",
        .udp_timeout = "UdpTimeout",
    };
};
