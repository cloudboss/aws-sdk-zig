const AssignedSessionActionDefinition = @import("assigned_session_action_definition.zig").AssignedSessionActionDefinition;

/// The action for a session defined by the session action ID.
pub const AssignedSessionAction = struct {
    /// The definition of the assigned session action.
    definition: AssignedSessionActionDefinition,

    /// The session action ID for the assigned session.
    session_action_id: []const u8,

    pub const json_field_names = .{
        .definition = "definition",
        .session_action_id = "sessionActionId",
    };
};
