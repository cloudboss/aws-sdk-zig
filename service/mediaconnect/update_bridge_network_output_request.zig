const Protocol = @import("protocol.zig").Protocol;

/// Update an existing network output.
pub const UpdateBridgeNetworkOutputRequest = struct {
    /// The network output IP Address.
    ip_address: ?[]const u8,

    /// The network output's gateway network name.
    network_name: ?[]const u8,

    /// The network output port.
    port: ?i32,

    /// The network output protocol.
    ///
    /// Elemental MediaConnect no longer supports the Fujitsu QoS protocol. This
    /// reference is maintained for legacy purposes only.
    protocol: ?Protocol,

    /// The network output TTL.
    ttl: ?i32,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .network_name = "NetworkName",
        .port = "Port",
        .protocol = "Protocol",
        .ttl = "Ttl",
    };
};
