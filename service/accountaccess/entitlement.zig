const PrincipalRoleEntitlement = @import("principal_role_entitlement.zig").PrincipalRoleEntitlement;

/// Specifies the entitlement configuration for an account access manager
/// application, defining which principal can assume which IAM role.
pub const Entitlement = union(enum) {
    /// The principal-to-role mapping for the entitlement.
    principal_role: ?PrincipalRoleEntitlement,

    pub const json_field_names = .{
        .principal_role = "principalRole",
    };
};
