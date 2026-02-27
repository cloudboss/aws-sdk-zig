const ConnectPeerBgpConfiguration = @import("connect_peer_bgp_configuration.zig").ConnectPeerBgpConfiguration;
const TunnelProtocol = @import("tunnel_protocol.zig").TunnelProtocol;

/// Describes a core network Connect peer configuration.
pub const ConnectPeerConfiguration = struct {
    /// The Connect peer BGP configurations.
    bgp_configurations: ?[]const ConnectPeerBgpConfiguration,

    /// The IP address of a core network.
    core_network_address: ?[]const u8,

    /// The inside IP addresses used for a Connect peer configuration.
    inside_cidr_blocks: ?[]const []const u8,

    /// The IP address of the Connect peer.
    peer_address: ?[]const u8,

    /// The protocol used for a Connect peer configuration.
    protocol: ?TunnelProtocol,

    pub const json_field_names = .{
        .bgp_configurations = "BgpConfigurations",
        .core_network_address = "CoreNetworkAddress",
        .inside_cidr_blocks = "InsideCidrBlocks",
        .peer_address = "PeerAddress",
        .protocol = "Protocol",
    };
};
