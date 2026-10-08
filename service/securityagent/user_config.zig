const UserRole = @import("user_role.zig").UserRole;

/// The configuration for a user membership, including the role assigned to the
/// user within the agent space.
pub const UserConfig = struct {
    /// The role assigned to the user. Currently, only MEMBER is supported.
    role: ?UserRole = null,

    pub const json_field_names = .{
        .role = "role",
    };
};
