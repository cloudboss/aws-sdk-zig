const Permission = @import("permission.zig").Permission;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;

/// Permissions granted to a principal.
pub const PrincipalPermissions = struct {
    /// The permissions that are granted to the principal.
    permissions: ?[]const Permission = null,

    /// The principal who is granted permissions.
    principal: ?DataLakePrincipal = null,

    pub const json_field_names = .{
        .permissions = "Permissions",
        .principal = "Principal",
    };
};
