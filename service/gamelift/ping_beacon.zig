const UDPEndpoint = @import("udp_endpoint.zig").UDPEndpoint;

/// Information about a UDP ping beacon that can be used to measure network
/// latency
/// between a player device and an Amazon GameLift Servers hosting location.
pub const PingBeacon = struct {
    /// The domain name and port of the UDP ping beacon.
    udp_endpoint: ?UDPEndpoint,

    pub const json_field_names = .{
        .udp_endpoint = "UDPEndpoint",
    };
};
