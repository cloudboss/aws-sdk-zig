/// The configuration of an OpenID Connect (OIDC) identity source for handling
/// access token claims. Contains the claim that you want to identify as the
/// principal in an authorization request, and the values of the `aud` claim, or
/// audiences, that you want to accept.
///
/// This data type is part of a
/// [OpenIdConnectTokenSelectionItem](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_OpenIdConnectTokenSelectionItem.html) structure, which is a parameter of [ListIdentitySources](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListIdentitySources.html).
pub const OpenIdConnectAccessTokenConfigurationItem = struct {
    /// The access token `aud` claim values that you want to accept in your policy
    /// store. For example, `https://myapp.example.com, https://myapp2.example.com`.
    audiences: ?[]const []const u8 = null,

    /// The claim that determines the principal in OIDC access tokens. For example,
    /// `sub`.
    principal_id_claim: []const u8 = "sub",

    pub const json_field_names = .{
        .audiences = "audiences",
        .principal_id_claim = "principalIdClaim",
    };
};
