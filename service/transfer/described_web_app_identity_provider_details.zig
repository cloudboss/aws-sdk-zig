const DescribedIdentityCenterConfig = @import("described_identity_center_config.zig").DescribedIdentityCenterConfig;

/// Returns a structure that contains the identity provider details for your web
/// app.
pub const DescribedWebAppIdentityProviderDetails = union(enum) {
    /// Returns a structure for your identity provider details. This structure
    /// contains the instance ARN and role being used for the web app.
    identity_center_config: ?DescribedIdentityCenterConfig,

    pub const json_field_names = .{
        .identity_center_config = "IdentityCenterConfig",
    };
};
