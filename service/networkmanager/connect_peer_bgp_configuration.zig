/// Describes a core network BGP configuration.
pub const ConnectPeerBgpConfiguration = struct {
    /// The address of a core network.
    core_network_address: ?[]const u8 = null,

    /// The ASN of the Coret Network.
    core_network_asn: ?i64 = null,

    /// The address of a core network Connect peer.
    peer_address: ?[]const u8 = null,

    /// The ASN of the Connect peer.
    peer_asn: ?i64 = null,

    pub const json_field_names = .{
        .core_network_address = "CoreNetworkAddress",
        .core_network_asn = "CoreNetworkAsn",
        .peer_address = "PeerAddress",
        .peer_asn = "PeerAsn",
    };
};
