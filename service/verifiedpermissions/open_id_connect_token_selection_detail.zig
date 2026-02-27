const OpenIdConnectAccessTokenConfigurationDetail = @import("open_id_connect_access_token_configuration_detail.zig").OpenIdConnectAccessTokenConfigurationDetail;
const OpenIdConnectIdentityTokenConfigurationDetail = @import("open_id_connect_identity_token_configuration_detail.zig").OpenIdConnectIdentityTokenConfigurationDetail;

/// The token type that you want to process from your OIDC identity provider.
/// Your policy store can process either identity (ID) or access tokens from a
/// given OIDC identity source.
///
/// This data type is part of a
/// [OpenIdConnectConfigurationDetail](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_OpenIdConnectConfigurationDetail.html) structure, which is a parameter of [GetIdentitySource](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_GetIdentitySource.html).
pub const OpenIdConnectTokenSelectionDetail = union(enum) {
    /// The OIDC configuration for processing access tokens. Contains allowed
    /// audience claims, for example `https://auth.example.com`, and the claim that
    /// you want to map to the principal, for example `sub`.
    access_token_only: ?OpenIdConnectAccessTokenConfigurationDetail,
    /// The OIDC configuration for processing identity (ID) tokens. Contains allowed
    /// client ID claims, for example `1example23456789`, and the claim that you
    /// want to map to the principal, for example `sub`.
    identity_token_only: ?OpenIdConnectIdentityTokenConfigurationDetail,

    pub const json_field_names = .{
        .access_token_only = "accessTokenOnly",
        .identity_token_only = "identityTokenOnly",
    };
};
