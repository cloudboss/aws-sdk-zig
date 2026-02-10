/// Describes the options when creating an Amazon Web Services Verified Access
/// trust provider using the `user`
/// type.
pub const CreateVerifiedAccessTrustProviderOidcOptions = struct {
    /// The OIDC authorization endpoint.
    authorization_endpoint: ?[]const u8,

    /// The client identifier.
    client_id: ?[]const u8,

    /// The client secret.
    client_secret: ?[]const u8,

    /// The OIDC issuer.
    issuer: ?[]const u8,

    /// OpenID Connect (OIDC) scopes are used by an application during
    /// authentication to authorize access to a user's details. Each scope returns a
    /// specific set of user attributes.
    scope: ?[]const u8,

    /// The OIDC token endpoint.
    token_endpoint: ?[]const u8,

    /// The OIDC user info endpoint.
    user_info_endpoint: ?[]const u8,
};
