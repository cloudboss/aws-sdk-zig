const IdentityCenterDetails = @import("identity_center_details.zig").IdentityCenterDetails;

/// Contains detailed information about the identity source for an application.
pub const IdentitySourceDetails = union(enum) {
    /// The IAM Identity Center configuration details for the identity source.
    identity_center: ?IdentityCenterDetails,

    pub const json_field_names = .{
        .identity_center = "identityCenter",
    };
};
