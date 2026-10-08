const PrincipalRoleEntitlementSummary = @import("principal_role_entitlement_summary.zig").PrincipalRoleEntitlementSummary;

/// Contains summary information about an entitlement.
pub const EntitlementSummary = union(enum) {
    /// The principal-to-role mapping summary for the entitlement.
    principal_role: ?PrincipalRoleEntitlementSummary,

    pub const json_field_names = .{
        .principal_role = "principalRole",
    };
};
