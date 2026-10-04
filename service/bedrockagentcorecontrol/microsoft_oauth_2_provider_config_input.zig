const SecretReference = @import("secret_reference.zig").SecretReference;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;

/// Input configuration for a Microsoft OAuth2 provider.
pub const MicrosoftOauth2ProviderConfigInput = struct {
    /// The client ID for the Microsoft OAuth2 provider.
    client_id: []const u8,

    /// The client secret for the Microsoft OAuth2 provider.
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

    /// The Microsoft Entra ID (formerly Azure AD) tenant ID for your organization.
    /// This identifies the specific tenant within Microsoft's identity platform
    /// where your application is registered.
    tenant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .client_secret_config = "clientSecretConfig",
        .client_secret_source = "clientSecretSource",
        .tenant_id = "tenantId",
    };
};
