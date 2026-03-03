/// Describes a route in a transit gateway route table.
pub const TransitGatewayRouteTableRoute = struct {
    /// The ID of the route attachment.
    attachment_id: ?[]const u8 = null,

    /// The CIDR block used for destination matches.
    destination_cidr: ?[]const u8 = null,

    /// The ID of the prefix list.
    prefix_list_id: ?[]const u8 = null,

    /// The ID of the resource for the route attachment.
    resource_id: ?[]const u8 = null,

    /// The resource type for the route attachment.
    resource_type: ?[]const u8 = null,

    /// The route origin. The following are the possible values:
    ///
    /// * static
    ///
    /// * propagated
    route_origin: ?[]const u8 = null,

    /// The state of the route.
    state: ?[]const u8 = null,
};
