const IdentityCenter = @import("identity_center.zig").IdentityCenter;

/// Specifies the identity source for an account access manager application.
pub const IdentitySource = union(enum) {
    /// The IAM Identity Center instance to use as the identity source.
    identity_center: ?IdentityCenter,

    pub const json_field_names = .{
        .identity_center = "identityCenter",
    };
};
