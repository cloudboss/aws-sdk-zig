/// Describes the OpenID Connect (OIDC) options.
pub const ModifyVerifiedAccessNativeApplicationOidcOptions = struct {
    /// The authorization endpoint of the IdP.
    authorization_endpoint: ?[]const u8 = null,

    /// The OAuth 2.0 client identifier.
    client_id: ?[]const u8 = null,

    /// The OAuth 2.0 client secret.
    client_secret: ?[]const u8 = null,

    /// The OIDC issuer identifier of the IdP.
    issuer: ?[]const u8 = null,

    /// The public signing key endpoint.
    public_signing_key_endpoint: ?[]const u8 = null,

    /// The set of user claims to be requested from the IdP.
    scope: ?[]const u8 = null,

    /// The token endpoint of the IdP.
    token_endpoint: ?[]const u8 = null,

    /// The user info endpoint of the IdP.
    user_info_endpoint: ?[]const u8 = null,
};
