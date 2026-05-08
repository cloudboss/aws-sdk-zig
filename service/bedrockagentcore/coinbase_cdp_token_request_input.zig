const PaymentHttpMethodType = @import("payment_http_method_type.zig").PaymentHttpMethodType;

/// Coinbase CDP token request parameters
pub const CoinbaseCdpTokenRequestInput = struct {
    /// Set to true for wallet write operations (requires walletSecret configured)
    include_wallet_auth_token: bool = false,

    /// Request body JSON - used to generate wallet auth JWT
    request_body: ?[]const u8 = null,

    /// Optional - defaults to "api.cdp.coinbase.com"
    request_host: ?[]const u8 = null,

    /// The HTTP method for the payment API request.
    request_method: PaymentHttpMethodType,

    /// The path of the payment API request.
    request_path: []const u8,

    pub const json_field_names = .{
        .include_wallet_auth_token = "includeWalletAuthToken",
        .request_body = "requestBody",
        .request_host = "requestHost",
        .request_method = "requestMethod",
        .request_path = "requestPath",
    };
};
