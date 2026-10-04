const SecretReference = @import("secret_reference.zig").SecretReference;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;

/// Stripe Privy configuration — credentials provided by Stripe and Privy.
pub const StripePrivyConfigurationInput = struct {
    /// The app ID provided by Privy.
    app_id: []const u8,

    /// The app secret provided by Privy.
    app_secret: []const u8 = "",

    /// A reference to the Amazon Web Services Secrets Manager secret that stores
    /// the app secret. This includes the secret ID and the JSON key used to extract
    /// the app secret value from the secret. Required when `appSecretSource` is set
    /// to `EXTERNAL`.
    app_secret_config: ?SecretReference = null,

    /// The source type of the app secret. Use `MANAGED` if the secret is managed by
    /// the service, or `EXTERNAL` if you manage the secret yourself in Amazon Web
    /// Services Secrets Manager.
    app_secret_source: ?SecretSourceType = null,

    /// The authorization ID for the Stripe Privy integration.
    authorization_id: []const u8,

    /// The authorization private key for the Stripe Privy integration.
    authorization_private_key: []const u8 = "",

    /// A reference to the Amazon Web Services Secrets Manager secret that stores
    /// the authorization private key. This includes the secret ID and the JSON key
    /// used to extract the authorization private key value from the secret.
    /// Required when `authorizationPrivateKeySource` is set to `EXTERNAL`.
    authorization_private_key_config: ?SecretReference = null,

    /// The source type of the authorization private key. Use `MANAGED` if the
    /// secret is managed by the service, or `EXTERNAL` if you manage the secret
    /// yourself in Amazon Web Services Secrets Manager.
    authorization_private_key_source: ?SecretSourceType = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_secret = "appSecret",
        .app_secret_config = "appSecretConfig",
        .app_secret_source = "appSecretSource",
        .authorization_id = "authorizationId",
        .authorization_private_key = "authorizationPrivateKey",
        .authorization_private_key_config = "authorizationPrivateKeyConfig",
        .authorization_private_key_source = "authorizationPrivateKeySource",
    };
};
