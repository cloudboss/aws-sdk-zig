const ClientAuthenticationMethodType = @import("client_authentication_method_type.zig").ClientAuthenticationMethodType;
const SecretReference = @import("secret_reference.zig").SecretReference;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;
const Oauth2Discovery = @import("oauth_2_discovery.zig").Oauth2Discovery;
const OnBehalfOfTokenExchangeConfigType = @import("on_behalf_of_token_exchange_config_type.zig").OnBehalfOfTokenExchangeConfigType;
const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;
const PrivateEndpointOverride = @import("private_endpoint_override.zig").PrivateEndpointOverride;
const PrivateKeyJwtConfig = @import("private_key_jwt_config.zig").PrivateKeyJwtConfig;

/// Input configuration for a custom OAuth2 provider.
pub const CustomOauth2ProviderConfigInput = struct {
    /// The client authentication method to use when authenticating with the token
    /// endpoint.
    client_authentication_method: ?ClientAuthenticationMethodType = null,

    /// The client ID for the custom OAuth2 provider.
    client_id: []const u8 = "",

    /// The client secret for the custom OAuth2 provider.
    client_secret: []const u8 = "",

    /// A reference to the Amazon Web Services Secrets Manager secret that stores
    /// the client secret. This includes the secret ID and the JSON key used to
    /// extract the client secret value from the secret. Required when
    /// `clientSecretSource` is set to `EXTERNAL`.
    client_secret_config: ?SecretReference = null,

    /// The source type of the client secret. Use `MANAGED` if the secret is managed
    /// by the service, or `EXTERNAL` if you manage the secret yourself in Amazon
    /// Web Services Secrets Manager.
    client_secret_source: ?SecretSourceType = null,

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

    /// The private_key_jwt client authentication configuration for this credential
    /// provider. When specified, the credential provider uses JWT client assertions
    /// to authenticate with the token endpoint.
    private_key_jwt_config: ?PrivateKeyJwtConfig = null,

    pub const json_field_names = .{
        .client_authentication_method = "clientAuthenticationMethod",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .client_secret_config = "clientSecretConfig",
        .client_secret_source = "clientSecretSource",
        .oauth_discovery = "oauthDiscovery",
        .on_behalf_of_token_exchange_config = "onBehalfOfTokenExchangeConfig",
        .private_endpoint = "privateEndpoint",
        .private_endpoint_overrides = "privateEndpointOverrides",
        .private_key_jwt_config = "privateKeyJwtConfig",
    };
};
