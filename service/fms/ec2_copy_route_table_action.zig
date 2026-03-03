const ActionTarget = @import("action_target.zig").ActionTarget;

/// An action that copies the EC2 route table for use in remediation.
pub const EC2CopyRouteTableAction = struct {
    /// A description of the copied EC2 route table that is associated with the
    /// remediation action.
    description: ?[]const u8 = null,

    /// The ID of the copied EC2 route table that is associated with the remediation
    /// action.
    route_table_id: ActionTarget,

    /// The VPC ID of the copied EC2 route table that is associated with the
    /// remediation action.
    vpc_id: ActionTarget,

    pub const json_field_names = .{
        .description = "Description",
        .route_table_id = "RouteTableId",
        .vpc_id = "VpcId",
    };
};
