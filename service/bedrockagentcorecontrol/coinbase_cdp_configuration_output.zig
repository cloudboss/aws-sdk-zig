const Secret = @import("secret.zig").Secret;

/// Coinbase CDP configuration output with secret ARNs
pub const CoinbaseCdpConfigurationOutput = struct {
    /// The API key identifier provided by Coinbase Developer Platform.
    api_key_id: []const u8,

    api_key_secret_arn: Secret,

    wallet_secret_arn: Secret,

    pub const json_field_names = .{
        .api_key_id = "apiKeyId",
        .api_key_secret_arn = "apiKeySecretArn",
        .wallet_secret_arn = "walletSecretArn",
    };
};
