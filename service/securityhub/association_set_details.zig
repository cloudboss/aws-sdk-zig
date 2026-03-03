const AssociationStateDetails = @import("association_state_details.zig").AssociationStateDetails;

/// The associations between a route table and one or more subnets or a gateway.
pub const AssociationSetDetails = struct {
    /// The state of the association between a route table and a subnet or gateway.
    association_state: ?AssociationStateDetails = null,

    /// The ID of the internet gateway or virtual private gateway.
    gateway_id: ?[]const u8 = null,

    /// Indicates whether this is the main route table.
    main: ?bool = null,

    /// The ID of the association.
    route_table_association_id: ?[]const u8 = null,

    /// The ID of the route table.
    route_table_id: ?[]const u8 = null,

    /// The ID of the subnet. A subnet ID is not returned for an implicit
    /// association.
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_state = "AssociationState",
        .gateway_id = "GatewayId",
        .main = "Main",
        .route_table_association_id = "RouteTableAssociationId",
        .route_table_id = "RouteTableId",
        .subnet_id = "SubnetId",
    };
};
