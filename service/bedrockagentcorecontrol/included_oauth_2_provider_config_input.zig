const SecretReference = @import("secret_reference.zig").SecretReference;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;

/// Configuration settings for connecting to a supported OAuth2 provider. This
/// includes client credentials and OAuth2 discovery information for providers
/// that have built-in support.
pub const IncludedOauth2ProviderConfigInput = struct {
    /// OAuth2 authorization endpoint for your isolated OAuth2 application tenant.
    /// This is where users are redirected to authenticate and authorize access to
    /// their resources.
    authorization_endpoint: ?[]const u8 = null,

    /// The client ID for the supported OAuth2 provider. This identifier is assigned
    /// by the OAuth2 provider when you register your application.
    client_id: []const u8,

    /// The client secret for the supported OAuth2 provider. This secret is assigned
    /// by the OAuth2 provider and used along with the client ID to authenticate
    /// your application.
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

    /// Token issuer of your isolated OAuth2 application tenant. This URL identifies
    /// the authorization server that issues tokens for this provider.
    issuer: ?[]const u8 = null,

    /// OAuth2 token endpoint for your isolated OAuth2 application tenant. This is
    /// where authorization codes are exchanged for access tokens.
    token_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_endpoint = "authorizationEndpoint",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .client_secret_config = "clientSecretConfig",
        .client_secret_source = "clientSecretSource",
        .issuer = "issuer",
        .token_endpoint = "tokenEndpoint",
    };
};
