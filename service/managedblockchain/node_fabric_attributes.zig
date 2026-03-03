/// Attributes of Hyperledger Fabric for a peer node on a Hyperledger Fabric
/// network on Managed Blockchain.
pub const NodeFabricAttributes = struct {
    /// The endpoint that identifies the peer node for all services except peer
    /// channel-based event services.
    peer_endpoint: ?[]const u8 = null,

    /// The endpoint that identifies the peer node for peer channel-based event
    /// services.
    peer_event_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .peer_endpoint = "PeerEndpoint",
        .peer_event_endpoint = "PeerEventEndpoint",
    };
};
