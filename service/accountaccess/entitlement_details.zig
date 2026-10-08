const PrincipalRoleEntitlementDetails = @import("principal_role_entitlement_details.zig").PrincipalRoleEntitlementDetails;

/// Contains detailed information about an entitlement, including the principal,
/// IAM role, and target account.
pub const EntitlementDetails = union(enum) {
    /// The principal-to-role mapping details for the entitlement, including the
    /// target account.
    principal_role: ?PrincipalRoleEntitlementDetails,

    pub const json_field_names = .{
        .principal_role = "principalRole",
    };
};
