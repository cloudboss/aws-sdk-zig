/// Coinbase CDP configuration - credentials provided by Coinbase Developer
/// Platform
pub const CoinbaseCdpConfigurationInput = struct {
    /// The API key identifier provided by Coinbase Developer Platform.
    api_key_id: []const u8,

    /// The API key secret provided by Coinbase Developer Platform.
    api_key_secret: []const u8,

    /// The wallet secret provided by Coinbase Developer Platform.
    wallet_secret: []const u8,

    pub const json_field_names = .{
        .api_key_id = "apiKeyId",
        .api_key_secret = "apiKeySecret",
        .wallet_secret = "walletSecret",
    };
};
