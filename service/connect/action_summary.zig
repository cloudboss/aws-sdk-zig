const ActionType = @import("action_type.zig").ActionType;

/// Information about an action.
pub const ActionSummary = struct {
    /// The action type.
    action_type: ActionType,

    pub const json_field_names = .{
        .action_type = "ActionType",
    };
};
