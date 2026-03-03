const RoutingControlState = @import("routing_control_state.zig").RoutingControlState;

/// A routing control, which is a simple on/off switch that you
/// can use to route traffic to cells. When a routing control state is set to
/// ON, traffic flows to a cell. When
/// the state is set to OFF, traffic does not flow.
pub const RoutingControl = struct {
    /// The Amazon Resource Name (ARN) of the control panel where the routing
    /// control is located.
    control_panel_arn: ?[]const u8 = null,

    /// The name of the control panel where the routing control is located. Only
    /// ASCII characters are supported for control
    /// panel names.
    control_panel_name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the routing control owner.
    owner: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the routing control.
    routing_control_arn: ?[]const u8 = null,

    /// The name of the routing control.
    routing_control_name: ?[]const u8 = null,

    /// The current state of the routing control. When a routing control state is
    /// set to ON, traffic flows to a cell. When
    /// the state is set to OFF, traffic does not flow.
    routing_control_state: ?RoutingControlState = null,

    pub const json_field_names = .{
        .control_panel_arn = "ControlPanelArn",
        .control_panel_name = "ControlPanelName",
        .owner = "Owner",
        .routing_control_arn = "RoutingControlArn",
        .routing_control_name = "RoutingControlName",
        .routing_control_state = "RoutingControlState",
    };
};
