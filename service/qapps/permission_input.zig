const Action = @import("action.zig").Action;

/// The permission to grant or revoke for a Amazon Q App.
pub const PermissionInput = struct {
    /// The action associated with the permission.
    action: Action,

    /// The principal user to which the permission applies.
    principal: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .principal = "principal",
    };
};
