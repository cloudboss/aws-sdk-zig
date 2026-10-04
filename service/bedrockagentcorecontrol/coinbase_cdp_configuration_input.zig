const SecretReference = @import("secret_reference.zig").SecretReference;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;

/// Coinbase CDP configuration — credentials provided by Coinbase Developer
/// Platform.
pub const CoinbaseCdpConfigurationInput = struct {
    /// The API key identifier provided by Coinbase Developer Platform.
    api_key_id: []const u8,

    /// The API key secret provided by Coinbase Developer Platform.
    api_key_secret: []const u8 = "",

    /// A reference to the Amazon Web Services Secrets Manager secret that stores
    /// the API key secret. This includes the secret ID and the JSON key used to
    /// extract the API key secret value from the secret. Required when
    /// `apiKeySecretSource` is set to `EXTERNAL`.
    api_key_secret_config: ?SecretReference = null,

    /// The source type of the API key secret for the Coinbase Developer Platform.
    /// Use `MANAGED` if the secret is managed by the service, or `EXTERNAL` if you
    /// manage the secret yourself in Amazon Web Services Secrets Manager.
    api_key_secret_source: ?SecretSourceType = null,

    /// The wallet secret provided by Coinbase Developer Platform.
    wallet_secret: []const u8 = "",

    /// A reference to the Amazon Web Services Secrets Manager secret that stores
    /// the wallet secret. This includes the secret ID and the JSON key used to
    /// extract the wallet secret value from the secret. Required when
    /// `walletSecretSource` is set to `EXTERNAL`.
    wallet_secret_config: ?SecretReference = null,

    /// The source type of the wallet secret for the Coinbase Developer Platform.
    /// Use `MANAGED` if the secret is managed by the service, or `EXTERNAL` if you
    /// manage the secret yourself in Amazon Web Services Secrets Manager.
    wallet_secret_source: ?SecretSourceType = null,

    pub const json_field_names = .{
        .api_key_id = "apiKeyId",
        .api_key_secret = "apiKeySecret",
        .api_key_secret_config = "apiKeySecretConfig",
        .api_key_secret_source = "apiKeySecretSource",
        .wallet_secret = "walletSecret",
        .wallet_secret_config = "walletSecretConfig",
        .wallet_secret_source = "walletSecretSource",
    };
};
