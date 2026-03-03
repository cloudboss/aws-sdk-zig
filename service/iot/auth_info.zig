const ActionType = @import("action_type.zig").ActionType;

/// A collection of authorization information.
pub const AuthInfo = struct {
    /// The type of action for which the principal is being authorized.
    action_type: ?ActionType = null,

    /// The resources for which the principal is being authorized to perform the
    /// specified
    /// action.
    resources: []const []const u8,

    pub const json_field_names = .{
        .action_type = "actionType",
        .resources = "resources",
    };
};
