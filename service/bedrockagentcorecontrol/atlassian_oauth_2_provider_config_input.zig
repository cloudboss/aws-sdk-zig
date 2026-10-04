const SecretReference = @import("secret_reference.zig").SecretReference;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;

/// Configuration settings for connecting to Atlassian services using OAuth2
/// authentication. This includes the client credentials required to
/// authenticate with Atlassian's OAuth2 authorization server.
pub const AtlassianOauth2ProviderConfigInput = struct {
    /// The client ID for the Atlassian OAuth2 provider. This identifier is assigned
    /// by Atlassian when you register your application.
    client_id: []const u8,

    /// The client secret for the Atlassian OAuth2 provider. This secret is assigned
    /// by Atlassian and used along with the client ID to authenticate your
    /// application.
    client_secret: []const u8 = "",

    /// A reference to the Amazon Web Services Secrets Manager secret that stores
    /// the client secret. This includes the secret ID and the JSON key used to
    /// extract the client secret value from the secret. Required when
    /// `clientSecretSource` is set to `EXTERNAL`.
    client_secret_config: ?SecretReference = null,

    /// The source type of the client secret for the Atlassian OAuth2 provider. Use
    /// `MANAGED` if the secret is managed by the service, or `EXTERNAL` if you
    /// manage the secret yourself in Amazon Web Services Secrets Manager.
    client_secret_source: ?SecretSourceType = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .client_secret_config = "clientSecretConfig",
        .client_secret_source = "clientSecretSource",
    };
};
