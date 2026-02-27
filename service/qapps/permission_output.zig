const Action = @import("action.zig").Action;
const PrincipalOutput = @import("principal_output.zig").PrincipalOutput;

/// The permission granted to the Amazon Q App.
pub const PermissionOutput = struct {
    /// The action associated with the permission.
    action: Action,

    /// The principal user to which the permission applies.
    principal: PrincipalOutput,

    pub const json_field_names = .{
        .action = "action",
        .principal = "principal",
    };
};
