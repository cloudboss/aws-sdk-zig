const Secret = @import("secret.zig").Secret;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;

/// Coinbase CDP configuration output with secret ARNs.
pub const CoinbaseCdpConfigurationOutput = struct {
    /// The API key identifier provided by Coinbase Developer Platform.
    api_key_id: []const u8,

    api_key_secret_arn: Secret,

    /// The JSON key used to extract the API key secret value from the Amazon Web
    /// Services Secrets Manager secret.
    api_key_secret_json_key: ?[]const u8 = null,

    /// The source type of the API key secret. Either `MANAGED` if the secret is
    /// managed by the service, or `EXTERNAL` if managed by the user in Amazon Web
    /// Services Secrets Manager.
    api_key_secret_source: ?SecretSourceType = null,

    wallet_secret_arn: Secret,

    /// The JSON key used to extract the wallet secret value from the Amazon Web
    /// Services Secrets Manager secret.
    wallet_secret_json_key: ?[]const u8 = null,

    /// The source type of the wallet secret. Either `MANAGED` if the secret is
    /// managed by the service, or `EXTERNAL` if managed by the user in Amazon Web
    /// Services Secrets Manager.
    wallet_secret_source: ?SecretSourceType = null,

    pub const json_field_names = .{
        .api_key_id = "apiKeyId",
        .api_key_secret_arn = "apiKeySecretArn",
        .api_key_secret_json_key = "apiKeySecretJsonKey",
        .api_key_secret_source = "apiKeySecretSource",
        .wallet_secret_arn = "walletSecretArn",
        .wallet_secret_json_key = "walletSecretJsonKey",
        .wallet_secret_source = "walletSecretSource",
    };
};
