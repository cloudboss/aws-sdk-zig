const TransitGatewayRouteTableState = @import("transit_gateway_route_table_state.zig").TransitGatewayRouteTableState;
const Tag = @import("tag.zig").Tag;

/// Describes a transit gateway route table.
pub const TransitGatewayRouteTable = struct {
    /// The creation time.
    creation_time: ?i64 = null,

    /// Indicates whether this is the default association route table for the
    /// transit gateway.
    default_association_route_table: ?bool = null,

    /// Indicates whether this is the default propagation route table for the
    /// transit gateway.
    default_propagation_route_table: ?bool = null,

    /// The state of the transit gateway route table.
    state: ?TransitGatewayRouteTableState = null,

    /// Any tags assigned to the route table.
    tags: ?[]const Tag = null,

    /// The ID of the transit gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of the transit gateway route table.
    transit_gateway_route_table_id: ?[]const u8 = null,
};
