const TransitGatewayRouteTableAnnouncementDirection = @import("transit_gateway_route_table_announcement_direction.zig").TransitGatewayRouteTableAnnouncementDirection;
const TransitGatewayRouteTableAnnouncementState = @import("transit_gateway_route_table_announcement_state.zig").TransitGatewayRouteTableAnnouncementState;
const Tag = @import("tag.zig").Tag;

/// Describes a transit gateway route table announcement.
pub const TransitGatewayRouteTableAnnouncement = struct {
    /// The direction for the route table announcement.
    announcement_direction: ?TransitGatewayRouteTableAnnouncementDirection = null,

    /// The ID of the core network for the transit gateway route table announcement.
    core_network_id: ?[]const u8 = null,

    /// The timestamp when the transit gateway route table announcement was created.
    creation_time: ?i64 = null,

    /// The ID of the core network ID for the peer.
    peer_core_network_id: ?[]const u8 = null,

    /// The ID of the peering attachment.
    peering_attachment_id: ?[]const u8 = null,

    /// The ID of the peer transit gateway.
    peer_transit_gateway_id: ?[]const u8 = null,

    /// The state of the transit gateway announcement.
    state: ?TransitGatewayRouteTableAnnouncementState = null,

    /// The key-value pairs associated with the route table announcement.
    tags: ?[]const Tag = null,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of the transit gateway route table announcement.
    transit_gateway_route_table_announcement_id: ?[]const u8 = null,

    /// The ID of the transit gateway route table.
    transit_gateway_route_table_id: ?[]const u8 = null,
};
