const AccessControlAccess = @import("access_control_access.zig").AccessControlAccess;
const AccessControlPrincipalType = @import("access_control_principal_type.zig").AccessControlPrincipalType;

/// An access control entry specifying a principal and their access level.
pub const DocumentAccessControlEntry = struct {
    /// Whether to allow or deny access.
    access: AccessControlAccess,

    /// The user identifier.
    name: []const u8,

    /// The type of principal.
    type: AccessControlPrincipalType,

    pub const json_field_names = .{
        .access = "access",
        .name = "name",
        .type = "type",
    };
};
