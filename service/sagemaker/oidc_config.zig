const aws = @import("aws");

/// Use this parameter to configure your OIDC Identity Provider (IdP).
pub const OidcConfig = struct {
    /// A string to string map of identifiers specific to the custom identity
    /// provider (IdP) being used.
    authentication_request_extra_params: ?[]const aws.map.StringMapEntry = null,

    /// The OIDC IdP authorization endpoint used to configure your private
    /// workforce.
    authorization_endpoint: []const u8,

    /// The OIDC IdP client ID used to configure your private workforce.
    client_id: []const u8,

    /// The OIDC IdP client secret used to configure your private workforce.
    client_secret: []const u8,

    /// The OIDC IdP issuer used to configure your private workforce.
    issuer: []const u8,

    /// The OIDC IdP JSON Web Key Set (Jwks) URI used to configure your private
    /// workforce.
    jwks_uri: []const u8,

    /// The OIDC IdP logout endpoint used to configure your private workforce.
    logout_endpoint: []const u8,

    /// An array of string identifiers used to refer to the specific pieces of user
    /// data or claims that the client application wants to access.
    scope: ?[]const u8 = null,

    /// The OIDC IdP token endpoint used to configure your private workforce.
    token_endpoint: []const u8,

    /// The OIDC IdP user information endpoint used to configure your private
    /// workforce.
    user_info_endpoint: []const u8,

    pub const json_field_names = .{
        .authentication_request_extra_params = "AuthenticationRequestExtraParams",
        .authorization_endpoint = "AuthorizationEndpoint",
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .issuer = "Issuer",
        .jwks_uri = "JwksUri",
        .logout_endpoint = "LogoutEndpoint",
        .scope = "Scope",
        .token_endpoint = "TokenEndpoint",
        .user_info_endpoint = "UserInfoEndpoint",
    };
};
