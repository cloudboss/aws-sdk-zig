const RoutingControlState = @import("routing_control_state.zig").RoutingControlState;

/// A routing control state entry.
pub const UpdateRoutingControlStateEntry = struct {
    /// The Amazon Resource Name (ARN) for a routing control state entry.
    routing_control_arn: []const u8,

    /// The routing control state in a set of routing control state entries.
    routing_control_state: RoutingControlState,

    pub const json_field_names = .{
        .routing_control_arn = "RoutingControlArn",
        .routing_control_state = "RoutingControlState",
    };
};
