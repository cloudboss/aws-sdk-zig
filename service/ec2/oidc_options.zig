/// Describes the options for an OpenID Connect-compatible user-identity trust
/// provider.
pub const OidcOptions = struct {
    /// The OIDC authorization endpoint.
    authorization_endpoint: ?[]const u8,

    /// The client identifier.
    client_id: ?[]const u8,

    /// The client secret.
    client_secret: ?[]const u8,

    /// The OIDC issuer.
    issuer: ?[]const u8,

    /// The OpenID Connect (OIDC) scope specified.
    scope: ?[]const u8,

    /// The OIDC token endpoint.
    token_endpoint: ?[]const u8,

    /// The OIDC user info endpoint.
    user_info_endpoint: ?[]const u8,
};
