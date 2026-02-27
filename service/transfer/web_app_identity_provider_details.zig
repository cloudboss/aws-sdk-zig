const IdentityCenterConfig = @import("identity_center_config.zig").IdentityCenterConfig;

/// A union that contains the `IdentityCenterConfig` object.
pub const WebAppIdentityProviderDetails = union(enum) {
    /// A structure that describes the values to use for the IAM Identity Center
    /// settings when you create a web app.
    identity_center_config: ?IdentityCenterConfig,

    pub const json_field_names = .{
        .identity_center_config = "IdentityCenterConfig",
    };
};
