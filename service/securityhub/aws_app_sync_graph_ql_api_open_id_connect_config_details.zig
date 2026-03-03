/// Specifies the authorization configuration for using an OpenID Connect
/// compliant service with your AppSync GraphQL
/// API endpoint.
pub const AwsAppSyncGraphQlApiOpenIdConnectConfigDetails = struct {
    /// The number of milliseconds that a token is valid after being authenticated.
    auth_tt_l: ?i64 = null,

    /// The client identifier of the relying party at the OpenID identity provider.
    /// This identifier is typically obtained
    /// when the relying party is registered with the OpenID identity provider. You
    /// can specify a regular expression so that
    /// AppSync can validate against multiple client identifiers at a time.
    client_id: ?[]const u8 = null,

    /// The number of milliseconds that a token is valid after it's issued to a
    /// user.
    iat_tt_l: ?i64 = null,

    /// The issuer for the OIDC configuration. The issuer returned by discovery must
    /// exactly match the value of `iss`
    /// in the ID token.
    issuer: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_tt_l = "AuthTtL",
        .client_id = "ClientId",
        .iat_tt_l = "IatTtL",
        .issuer = "Issuer",
    };
};
