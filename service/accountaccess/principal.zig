const IdentityCenterPrincipal = @import("identity_center_principal.zig").IdentityCenterPrincipal;

/// Identifies a principal (user or group) that can be granted entitlements.
pub const Principal = union(enum) {
    /// The IAM Identity Center principal (user or group).
    identity_center: ?IdentityCenterPrincipal,

    pub const json_field_names = .{
        .identity_center = "identityCenter",
    };
};
