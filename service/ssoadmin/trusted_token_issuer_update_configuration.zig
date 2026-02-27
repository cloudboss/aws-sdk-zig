const OidcJwtUpdateConfiguration = @import("oidc_jwt_update_configuration.zig").OidcJwtUpdateConfiguration;

/// A structure that contains details to be updated for a trusted token issuer
/// configuration. The structure and settings that you can include depend on the
/// type of the trusted token issuer being updated.
pub const TrustedTokenIssuerUpdateConfiguration = union(enum) {
    /// A structure that describes an updated configuration for a trusted token
    /// issuer that uses OpenID Connect (OIDC) with JSON web tokens (JWT).
    oidc_jwt_configuration: ?OidcJwtUpdateConfiguration,

    pub const json_field_names = .{
        .oidc_jwt_configuration = "OidcJwtConfiguration",
    };
};
