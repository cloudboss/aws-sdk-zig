const OpenIdConnectAccessTokenConfiguration = @import("open_id_connect_access_token_configuration.zig").OpenIdConnectAccessTokenConfiguration;
const OpenIdConnectIdentityTokenConfiguration = @import("open_id_connect_identity_token_configuration.zig").OpenIdConnectIdentityTokenConfiguration;

/// The token type that you want to process from your OIDC identity provider.
/// Your policy store can process either identity (ID) or access tokens from a
/// given OIDC identity source.
///
/// This data type is part of a
/// [OpenIdConnectConfiguration](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_OpenIdConnectConfiguration.html) structure, which is a parameter of [CreateIdentitySource](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreateIdentitySource.html).
pub const OpenIdConnectTokenSelection = union(enum) {
    /// The OIDC configuration for processing access tokens. Contains allowed
    /// audience claims, for example `https://auth.example.com`, and the claim that
    /// you want to map to the principal, for example `sub`.
    access_token_only: ?OpenIdConnectAccessTokenConfiguration,
    /// The OIDC configuration for processing identity (ID) tokens. Contains allowed
    /// client ID claims, for example `1example23456789`, and the claim that you
    /// want to map to the principal, for example `sub`.
    identity_token_only: ?OpenIdConnectIdentityTokenConfiguration,

    pub const json_field_names = .{
        .access_token_only = "accessTokenOnly",
        .identity_token_only = "identityTokenOnly",
    };
};
