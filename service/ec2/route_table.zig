const RouteTableAssociation = @import("route_table_association.zig").RouteTableAssociation;
const PropagatingVgw = @import("propagating_vgw.zig").PropagatingVgw;
const Route = @import("route.zig").Route;
const Tag = @import("tag.zig").Tag;

/// Describes a route table.
pub const RouteTable = struct {
    /// The associations between the route table and your subnets or gateways.
    associations: ?[]const RouteTableAssociation,

    /// The ID of the Amazon Web Services account that owns the route table.
    owner_id: ?[]const u8,

    /// Any virtual private gateway (VGW) propagating routes.
    propagating_vgws: ?[]const PropagatingVgw,

    /// The routes in the route table.
    routes: ?[]const Route,

    /// The ID of the route table.
    route_table_id: ?[]const u8,

    /// Any tags assigned to the route table.
    tags: ?[]const Tag,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,
};
