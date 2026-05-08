/// Coinbase CDP token response
pub const CoinbaseCdpTokenResponseOutput = struct {
    /// Bearer Token for Authorization header
    bearer_token: []const u8,

    /// Wallet Auth Token for X-Wallet-Auth header
    wallet_auth_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bearer_token = "bearerToken",
        .wallet_auth_token = "walletAuthToken",
    };
};
