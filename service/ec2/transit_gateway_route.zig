const TransitGatewayRouteState = @import("transit_gateway_route_state.zig").TransitGatewayRouteState;
const TransitGatewayRouteAttachment = @import("transit_gateway_route_attachment.zig").TransitGatewayRouteAttachment;
const TransitGatewayRouteType = @import("transit_gateway_route_type.zig").TransitGatewayRouteType;

/// Describes a route for a transit gateway route table.
pub const TransitGatewayRoute = struct {
    /// The CIDR block used for destination matches.
    destination_cidr_block: ?[]const u8 = null,

    /// The ID of the prefix list used for destination matches.
    prefix_list_id: ?[]const u8 = null,

    /// The state of the route.
    state: ?TransitGatewayRouteState = null,

    /// The attachments.
    transit_gateway_attachments: ?[]const TransitGatewayRouteAttachment = null,

    /// The ID of the transit gateway route table announcement.
    transit_gateway_route_table_announcement_id: ?[]const u8 = null,

    /// The route type.
    @"type": ?TransitGatewayRouteType = null,
};
