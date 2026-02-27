const OidcIdentityProviderConfig = @import("oidc_identity_provider_config.zig").OidcIdentityProviderConfig;

/// The full description of your identity configuration.
pub const IdentityProviderConfigResponse = struct {
    /// An object representing an OpenID Connect (OIDC) identity provider
    /// configuration.
    oidc: ?OidcIdentityProviderConfig,

    pub const json_field_names = .{
        .oidc = "oidc",
    };
};
