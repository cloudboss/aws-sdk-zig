const ClientAuthenticationMethodType = @import("client_authentication_method_type.zig").ClientAuthenticationMethodType;
const Oauth2Discovery = @import("oauth_2_discovery.zig").Oauth2Discovery;
const OnBehalfOfTokenExchangeConfigType = @import("on_behalf_of_token_exchange_config_type.zig").OnBehalfOfTokenExchangeConfigType;
const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;
const PrivateEndpointOverride = @import("private_endpoint_override.zig").PrivateEndpointOverride;

/// Input configuration for a custom OAuth2 provider.
pub const CustomOauth2ProviderConfigInput = struct {
    /// The client authentication method to use when authenticating with the token
    /// endpoint.
    client_authentication_method: ?ClientAuthenticationMethodType = null,

    /// The client ID for the custom OAuth2 provider.
    client_id: []const u8 = "",

    /// The client secret for the custom OAuth2 provider.
    client_secret: []const u8 = "",

    /// The OAuth2 discovery information for the custom provider.
    oauth_discovery: Oauth2Discovery,

    /// The configuration for on-behalf-of token exchange. This enables
    /// authentication flows that use RFC 8693 token exchange or RFC 7523 JWT
    /// authorization grants.
    on_behalf_of_token_exchange_config: ?OnBehalfOfTokenExchangeConfigType = null,

    /// The default private endpoint for the custom OAuth2 provider, enabling secure
    /// connectivity through a VPC Lattice resource configuration.
    private_endpoint: ?PrivateEndpoint = null,

    /// The private endpoint overrides for the custom OAuth2 provider configuration.
    private_endpoint_overrides: ?[]const PrivateEndpointOverride = null,

    pub const json_field_names = .{
        .client_authentication_method = "clientAuthenticationMethod",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .oauth_discovery = "oauthDiscovery",
        .on_behalf_of_token_exchange_config = "onBehalfOfTokenExchangeConfig",
        .private_endpoint = "privateEndpoint",
        .private_endpoint_overrides = "privateEndpointOverrides",
    };
};
