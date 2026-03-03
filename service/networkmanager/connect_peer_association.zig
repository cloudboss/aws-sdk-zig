const ConnectPeerAssociationState = @import("connect_peer_association_state.zig").ConnectPeerAssociationState;

/// Describes a core network Connect peer association.
pub const ConnectPeerAssociation = struct {
    /// The ID of the Connect peer.
    connect_peer_id: ?[]const u8 = null,

    /// The ID of the device to connect to.
    device_id: ?[]const u8 = null,

    /// The ID of the global network.
    global_network_id: ?[]const u8 = null,

    /// The ID of the link.
    link_id: ?[]const u8 = null,

    /// The state of the Connect peer association.
    state: ?ConnectPeerAssociationState = null,

    pub const json_field_names = .{
        .connect_peer_id = "ConnectPeerId",
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
        .state = "State",
    };
};
