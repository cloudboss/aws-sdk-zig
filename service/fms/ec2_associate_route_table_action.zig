const ActionTarget = @import("action_target.zig").ActionTarget;

/// The action of associating an EC2 resource, such as a subnet or internet
/// gateway, with a route table.
pub const EC2AssociateRouteTableAction = struct {
    /// A description of the EC2 route table that is associated with the remediation
    /// action.
    description: ?[]const u8,

    /// The ID of the gateway to be used with the EC2 route table that is associated
    /// with the remediation action.
    gateway_id: ?ActionTarget,

    /// The ID of the EC2 route table that is associated with the remediation
    /// action.
    route_table_id: ActionTarget,

    /// The ID of the subnet for the EC2 route table that is associated with the
    /// remediation action.
    subnet_id: ?ActionTarget,

    pub const json_field_names = .{
        .description = "Description",
        .gateway_id = "GatewayId",
        .route_table_id = "RouteTableId",
        .subnet_id = "SubnetId",
    };
};
