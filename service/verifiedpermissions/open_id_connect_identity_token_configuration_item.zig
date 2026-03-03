/// The configuration of an OpenID Connect (OIDC) identity source for handling
/// identity (ID) token claims. Contains the claim that you want to identify as
/// the principal in an authorization request, and the values of the `aud`
/// claim, or audiences, that you want to accept.
///
/// This data type is part of a
/// [OpenIdConnectTokenSelectionItem](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_OpenIdConnectTokenSelectionItem.html) structure, which is a parameter of [ListIdentitySources](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListIdentitySources.html).
pub const OpenIdConnectIdentityTokenConfigurationItem = struct {
    /// The ID token audience, or client ID, claim values that you want to accept in
    /// your policy store from an OIDC identity provider. For example,
    /// `1example23456789, 2example10111213`.
    client_ids: ?[]const []const u8 = null,

    /// The claim that determines the principal in OIDC access tokens. For example,
    /// `sub`.
    principal_id_claim: []const u8 = "sub",

    pub const json_field_names = .{
        .client_ids = "clientIds",
        .principal_id_claim = "principalIdClaim",
    };
};
