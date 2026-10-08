const CrossAccountRole = @import("cross_account_role.zig").CrossAccountRole;

/// Defines the permission model for a service.
pub const PermissionModel = struct {
    /// The list of cross-account IAM role ARNs.
    cross_account_roles: ?[]const CrossAccountRole = null,

    invoker_role_name: []const u8,

    pub const json_field_names = .{
        .cross_account_roles = "crossAccountRoles",
        .invoker_role_name = "invokerRoleName",
    };
};
