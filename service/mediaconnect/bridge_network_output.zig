const Protocol = @import("protocol.zig").Protocol;

/// The output of the bridge. A network output is delivered to your premises.
pub const BridgeNetworkOutput = struct {
    /// The network output IP address.
    ip_address: []const u8,

    /// The network output name.
    name: []const u8,

    /// The network output's gateway network name.
    network_name: []const u8,

    /// The network output's port.
    port: i32,

    /// The network output protocol.
    ///
    /// Elemental MediaConnect no longer supports the Fujitsu QoS protocol. This
    /// reference is maintained for legacy purposes only.
    protocol: Protocol,

    /// The network output TTL.
    ttl: i32,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .name = "Name",
        .network_name = "NetworkName",
        .port = "Port",
        .protocol = "Protocol",
        .ttl = "Ttl",
    };
};
