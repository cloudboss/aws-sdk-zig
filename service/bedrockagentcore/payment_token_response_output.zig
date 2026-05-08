const CoinbaseCdpTokenResponseOutput = @import("coinbase_cdp_token_response_output.zig").CoinbaseCdpTokenResponseOutput;
const StripePrivyTokenResponseOutput = @import("stripe_privy_token_response_output.zig").StripePrivyTokenResponseOutput;

/// VENDOR-SPECIFIC TOKEN RESPONSE CONFIGURATION - Output
pub const PaymentTokenResponseOutput = union(enum) {
    coinbase_cdp_token_response: ?CoinbaseCdpTokenResponseOutput,
    stripe_privy_token_response: ?StripePrivyTokenResponseOutput,

    pub const json_field_names = .{
        .coinbase_cdp_token_response = "coinbaseCdpTokenResponse",
        .stripe_privy_token_response = "stripePrivyTokenResponse",
    };
};
