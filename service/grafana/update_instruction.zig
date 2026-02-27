const UpdateAction = @import("update_action.zig").UpdateAction;
const Role = @import("role.zig").Role;
const User = @import("user.zig").User;

/// Contains the instructions for one Grafana role permission update in a
/// [UpdatePermissions](https://docs.aws.amazon.com/grafana/latest/APIReference/API_UpdatePermissions.html) operation.
pub const UpdateInstruction = struct {
    /// Specifies whether this update is to add or revoke role permissions.
    action: UpdateAction,

    /// The role to add or revoke for the user or the group specified in
    /// `users`.
    role: Role,

    /// A structure that specifies the user or group to add or revoke the role for.
    users: []const User,

    pub const json_field_names = .{
        .action = "action",
        .role = "role",
        .users = "users",
    };
};
