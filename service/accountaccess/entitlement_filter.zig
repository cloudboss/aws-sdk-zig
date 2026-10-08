const PrincipalRoleEntitlementFilter = @import("principal_role_entitlement_filter.zig").PrincipalRoleEntitlementFilter;

/// Specifies filter criteria for listing entitlements.
pub const EntitlementFilter = struct {
    /// The principal-to-role filter criteria for narrowing entitlement results.
    principal_role: ?PrincipalRoleEntitlementFilter = null,

    pub const json_field_names = .{
        .principal_role = "principalRole",
    };
};
