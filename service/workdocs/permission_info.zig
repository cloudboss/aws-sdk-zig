const RoleType = @import("role_type.zig").RoleType;
const RolePermissionType = @import("role_permission_type.zig").RolePermissionType;

/// Describes the permissions.
pub const PermissionInfo = struct {
    /// The role of the user.
    role: ?RoleType,

    /// The type of permissions.
    @"type": ?RolePermissionType,

    pub const json_field_names = .{
        .role = "Role",
        .@"type" = "Type",
    };
};
