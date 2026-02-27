const TransitGatewayConnectPeerAssociationState = @import("transit_gateway_connect_peer_association_state.zig").TransitGatewayConnectPeerAssociationState;

/// Describes a transit gateway Connect peer association.
pub const TransitGatewayConnectPeerAssociation = struct {
    /// The ID of the device.
    device_id: ?[]const u8,

    /// The ID of the global network.
    global_network_id: ?[]const u8,

    /// The ID of the link.
    link_id: ?[]const u8,

    /// The state of the association.
    state: ?TransitGatewayConnectPeerAssociationState,

    /// The Amazon Resource Name (ARN) of the transit gateway Connect peer.
    transit_gateway_connect_peer_arn: ?[]const u8,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
        .state = "State",
        .transit_gateway_connect_peer_arn = "TransitGatewayConnectPeerArn",
    };
};
