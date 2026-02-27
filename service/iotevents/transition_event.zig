const Action = @import("action.zig").Action;

/// Specifies the actions performed and the next state entered when a
/// `condition`
/// evaluates to TRUE.
pub const TransitionEvent = struct {
    /// The actions to be performed.
    actions: ?[]const Action,

    /// Required. A Boolean expression that when TRUE causes the actions to be
    /// performed and the
    /// `nextState` to be entered.
    condition: []const u8,

    /// The name of the transition event.
    event_name: []const u8,

    /// The next state to enter.
    next_state: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .condition = "condition",
        .event_name = "eventName",
        .next_state = "nextState",
    };
};
