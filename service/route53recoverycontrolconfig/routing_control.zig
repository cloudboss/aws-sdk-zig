const Status = @import("status.zig").Status;

/// A routing control has one of two states: ON and OFF. You can map the routing
/// control state to the state of an Amazon Route 53 health check, which can be
/// used to control traffic routing.
pub const RoutingControl = struct {
    /// The Amazon Resource Name (ARN) of the control panel that includes the
    /// routing control.
    control_panel_arn: ?[]const u8 = null,

    /// The name of the routing control.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the routing control owner.
    owner: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the routing control.
    routing_control_arn: ?[]const u8 = null,

    /// The deployment status of a routing control. Status can be one of the
    /// following: PENDING, DEPLOYED, PENDING_DELETION.
    status: ?Status = null,

    pub const json_field_names = .{
        .control_panel_arn = "ControlPanelArn",
        .name = "Name",
        .owner = "Owner",
        .routing_control_arn = "RoutingControlArn",
        .status = "Status",
    };
};
