const AssociationSetDetails = @import("association_set_details.zig").AssociationSetDetails;
const PropagatingVgwSetDetails = @import("propagating_vgw_set_details.zig").PropagatingVgwSetDetails;
const RouteSetDetails = @import("route_set_details.zig").RouteSetDetails;

/// Provides details about a route table for the specified VPC.
pub const AwsEc2RouteTableDetails = struct {
    /// The associations between a route table and one or more subnets or a gateway.
    association_set: ?[]const AssociationSetDetails = null,

    /// The ID of the Amazon Web Services account that owns the route table.
    owner_id: ?[]const u8 = null,

    /// Describes a virtual private gateway propagating route.
    propagating_vgw_set: ?[]const PropagatingVgwSetDetails = null,

    /// The routes in the route table.
    route_set: ?[]const RouteSetDetails = null,

    /// The ID of the route table.
    route_table_id: ?[]const u8 = null,

    /// The ID of the virtual private cloud (VPC).
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_set = "AssociationSet",
        .owner_id = "OwnerId",
        .propagating_vgw_set = "PropagatingVgwSet",
        .route_set = "RouteSet",
        .route_table_id = "RouteTableId",
        .vpc_id = "VpcId",
    };
};
