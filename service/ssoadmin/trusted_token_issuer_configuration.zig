const OidcJwtConfiguration = @import("oidc_jwt_configuration.zig").OidcJwtConfiguration;

/// A structure that describes the configuration of a trusted token issuer. The
/// structure and available settings are determined by the type of the trusted
/// token issuer.
pub const TrustedTokenIssuerConfiguration = union(enum) {
    /// A structure that describes the settings for a trusted token issuer that
    /// works with OpenID Connect (OIDC) by using JSON Web Tokens (JWT).
    oidc_jwt_configuration: ?OidcJwtConfiguration,

    pub const json_field_names = .{
        .oidc_jwt_configuration = "OidcJwtConfiguration",
    };
};
