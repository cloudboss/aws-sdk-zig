const ActionTarget = @import("action_target.zig").ActionTarget;

/// Information about the CreateRouteTable action in Amazon EC2.
pub const EC2CreateRouteTableAction = struct {
    /// A description of the CreateRouteTable action.
    description: ?[]const u8 = null,

    /// Information about the ID of a VPC.
    vpc_id: ActionTarget,

    pub const json_field_names = .{
        .description = "Description",
        .vpc_id = "VpcId",
    };
};
