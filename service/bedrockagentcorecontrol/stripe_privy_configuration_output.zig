const Secret = @import("secret.zig").Secret;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;

/// Stripe Privy configuration output with secret ARNs.
pub const StripePrivyConfigurationOutput = struct {
    /// The app ID provided by Privy.
    app_id: []const u8,

    app_secret_arn: Secret,

    /// The JSON key used to extract the app secret value from the Amazon Web
    /// Services Secrets Manager secret.
    app_secret_json_key: ?[]const u8 = null,

    /// The source type of the app secret. Either `MANAGED` if the secret is managed
    /// by the service, or `EXTERNAL` if managed by the user in Amazon Web Services
    /// Secrets Manager.
    app_secret_source: ?SecretSourceType = null,

    /// The authorization ID for the Stripe Privy integration.
    authorization_id: []const u8,

    authorization_private_key_arn: Secret,

    /// The JSON key used to extract the authorization private key value from the
    /// Amazon Web Services Secrets Manager secret.
    authorization_private_key_json_key: ?[]const u8 = null,

    /// The source type of the authorization private key. Either `MANAGED` if the
    /// secret is managed by the service, or `EXTERNAL` if managed by the user in
    /// Amazon Web Services Secrets Manager.
    authorization_private_key_source: ?SecretSourceType = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_secret_arn = "appSecretArn",
        .app_secret_json_key = "appSecretJsonKey",
        .app_secret_source = "appSecretSource",
        .authorization_id = "authorizationId",
        .authorization_private_key_arn = "authorizationPrivateKeyArn",
        .authorization_private_key_json_key = "authorizationPrivateKeyJsonKey",
        .authorization_private_key_source = "authorizationPrivateKeySource",
    };
};
