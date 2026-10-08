const IdentityCenterPrincipalFilter = @import("identity_center_principal_filter.zig").IdentityCenterPrincipalFilter;

/// Specifies filter criteria for a principal.
pub const PrincipalFilter = union(enum) {
    /// The IAM Identity Center principal filter criteria.
    identity_center: ?IdentityCenterPrincipalFilter,

    pub const json_field_names = .{
        .identity_center = "identityCenter",
    };
};
