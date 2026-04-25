const Role = @import("role.zig").Role;
const User = @import("user.zig").User;

/// A structure containing the identity of one user or group and the `Admin`,
/// `Editor`, or `Viewer` role that they have.
pub const PermissionEntry = struct {
    /// Specifies whether the user or group has the `Admin`, `Editor`, or `Viewer`
    /// role.
    role: Role,

    /// A structure with the ID of the user or group with this role.
    user: User,

    pub const json_field_names = .{
        .role = "role",
        .user = "user",
    };
};
