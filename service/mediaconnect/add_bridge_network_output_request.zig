const Protocol = @import("protocol.zig").Protocol;

/// Add a network output to an existing bridge.
pub const AddBridgeNetworkOutputRequest = struct {
    /// The network output IP Address.
    ip_address: []const u8,

    /// The network output name. This name is used to reference the output and must
    /// be unique among outputs in this bridge.
    name: []const u8,

    /// The network output's gateway network name.
    network_name: []const u8,

    /// The network output port.
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
