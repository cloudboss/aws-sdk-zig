const UpdateWebAppIdentityCenterConfig = @import("update_web_app_identity_center_config.zig").UpdateWebAppIdentityCenterConfig;

/// A union that contains the `UpdateWebAppIdentityCenterConfig` object.
pub const UpdateWebAppIdentityProviderDetails = union(enum) {
    /// A structure that describes the values to use for the IAM Identity Center
    /// settings when you update a web app.
    identity_center_config: ?UpdateWebAppIdentityCenterConfig,

    pub const json_field_names = .{
        .identity_center_config = "IdentityCenterConfig",
    };
};
