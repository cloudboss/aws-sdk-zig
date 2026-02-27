const MulticastSourceSettings = @import("multicast_source_settings.zig").MulticastSourceSettings;
const Protocol = @import("protocol.zig").Protocol;

/// Update the network source of the bridge.
pub const UpdateBridgeNetworkSourceRequest = struct {
    /// The network source multicast IP.
    multicast_ip: ?[]const u8,

    /// The settings related to the multicast source.
    multicast_source_settings: ?MulticastSourceSettings,

    /// The network source's gateway network name.
    network_name: ?[]const u8,

    /// The network source port.
    port: ?i32,

    /// The network source protocol.
    ///
    /// Elemental MediaConnect no longer supports the Fujitsu QoS protocol. This
    /// reference is maintained for legacy purposes only.
    protocol: ?Protocol,

    pub const json_field_names = .{
        .multicast_ip = "MulticastIp",
        .multicast_source_settings = "MulticastSourceSettings",
        .network_name = "NetworkName",
        .port = "Port",
        .protocol = "Protocol",
    };
};
