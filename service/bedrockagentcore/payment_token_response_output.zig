const CoinbaseCdpTokenResponseOutput = @import("coinbase_cdp_token_response_output.zig").CoinbaseCdpTokenResponseOutput;
const StripePrivyTokenResponseOutput = @import("stripe_privy_token_response_output.zig").StripePrivyTokenResponseOutput;

/// Vendor-specific token response configuration.
pub const PaymentTokenResponseOutput = union(enum) {
    /// The Coinbase CDP token response.
    coinbase_cdp_token_response: ?CoinbaseCdpTokenResponseOutput,
    /// The Stripe Privy token response.
    stripe_privy_token_response: ?StripePrivyTokenResponseOutput,

    pub const json_field_names = .{
        .coinbase_cdp_token_response = "coinbaseCdpTokenResponse",
        .stripe_privy_token_response = "stripePrivyTokenResponse",
    };
};
