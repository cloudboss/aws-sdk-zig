/// Describes an OpenID Connect (OIDC) configuration.
pub const OpenIDConnectConfig = struct {
    /// The number of milliseconds that a token is valid after being authenticated.
    auth_ttl: i64 = 0,

    /// The client identifier of the relying party at the OpenID identity provider.
    /// This
    /// identifier is typically obtained when the relying party is registered with
    /// the OpenID
    /// identity provider. You can specify a regular expression so that AppSync can
    /// validate against multiple client identifiers at a time.
    client_id: ?[]const u8,

    /// The number of milliseconds that a token is valid after it's issued to a
    /// user.
    iat_ttl: i64 = 0,

    /// The issuer for the OIDC configuration. The issuer returned by discovery must
    /// exactly
    /// match the value of `iss` in the ID token.
    issuer: []const u8,

    pub const json_field_names = .{
        .auth_ttl = "authTTL",
        .client_id = "clientId",
        .iat_ttl = "iatTTL",
        .issuer = "issuer",
    };
};
