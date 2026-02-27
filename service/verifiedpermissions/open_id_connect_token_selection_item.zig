const OpenIdConnectAccessTokenConfigurationItem = @import("open_id_connect_access_token_configuration_item.zig").OpenIdConnectAccessTokenConfigurationItem;
const OpenIdConnectIdentityTokenConfigurationItem = @import("open_id_connect_identity_token_configuration_item.zig").OpenIdConnectIdentityTokenConfigurationItem;

/// The token type that you want to process from your OIDC identity provider.
/// Your policy store can process either identity (ID) or access tokens from a
/// given OIDC identity source.
///
/// This data type is part of a
/// [OpenIdConnectConfigurationItem](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_OpenIdConnectConfigurationItem.html) structure, which is a parameter of [ListIdentitySources](http://amazonaws.com/verifiedpermissions/latest/apireference/API_ListIdentitySources.html).
pub const OpenIdConnectTokenSelectionItem = union(enum) {
    /// The OIDC configuration for processing access tokens. Contains allowed
    /// audience claims, for example `https://auth.example.com`, and the claim that
    /// you want to map to the principal, for example `sub`.
    access_token_only: ?OpenIdConnectAccessTokenConfigurationItem,
    /// The OIDC configuration for processing identity (ID) tokens. Contains allowed
    /// client ID claims, for example `1example23456789`, and the claim that you
    /// want to map to the principal, for example `sub`.
    identity_token_only: ?OpenIdConnectIdentityTokenConfigurationItem,

    pub const json_field_names = .{
        .access_token_only = "accessTokenOnly",
        .identity_token_only = "identityTokenOnly",
    };
};
