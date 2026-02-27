const RoutingControlStateChange = @import("routing_control_state_change.zig").RoutingControlStateChange;

/// Represents the state of an ARC routing control.
pub const ArcRoutingControlState = struct {
    /// The Amazon Resource Name (ARN) of a routing control.
    routing_control_arn: []const u8,

    /// The state of an ARC routing control, On or Off.
    state: RoutingControlStateChange,

    pub const json_field_names = .{
        .routing_control_arn = "routingControlArn",
        .state = "state",
    };
};
