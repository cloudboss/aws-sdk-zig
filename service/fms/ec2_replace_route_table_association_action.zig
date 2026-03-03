const ActionTarget = @import("action_target.zig").ActionTarget;

/// Information about the ReplaceRouteTableAssociation action in Amazon EC2.
pub const EC2ReplaceRouteTableAssociationAction = struct {
    /// Information about the association ID.
    association_id: ActionTarget,

    /// A description of the ReplaceRouteTableAssociation action in Amazon EC2.
    description: ?[]const u8 = null,

    /// Information about the ID of the new route table to associate with the
    /// subnet.
    route_table_id: ActionTarget,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .description = "Description",
        .route_table_id = "RouteTableId",
    };
};
