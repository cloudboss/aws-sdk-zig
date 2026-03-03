const TransitGatewayConnectPeerConfiguration = @import("transit_gateway_connect_peer_configuration.zig").TransitGatewayConnectPeerConfiguration;
const TransitGatewayConnectPeerState = @import("transit_gateway_connect_peer_state.zig").TransitGatewayConnectPeerState;
const Tag = @import("tag.zig").Tag;

/// Describes a transit gateway Connect peer.
pub const TransitGatewayConnectPeer = struct {
    /// The Connect peer details.
    connect_peer_configuration: ?TransitGatewayConnectPeerConfiguration = null,

    /// The creation time.
    creation_time: ?i64 = null,

    /// The state of the Connect peer.
    state: ?TransitGatewayConnectPeerState = null,

    /// The tags for the Connect peer.
    tags: ?[]const Tag = null,

    /// The ID of the Connect attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,

    /// The ID of the Connect peer.
    transit_gateway_connect_peer_id: ?[]const u8 = null,
};
