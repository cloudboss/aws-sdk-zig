const CoinbaseCdpTokenRequestInput = @import("coinbase_cdp_token_request_input.zig").CoinbaseCdpTokenRequestInput;
const StripePrivyTokenRequestInput = @import("stripe_privy_token_request_input.zig").StripePrivyTokenRequestInput;

/// Vendor-specific token request configuration.
pub const PaymentTokenRequestInput = union(enum) {
    /// The Coinbase CDP token request.
    coinbase_cdp_token_request: ?CoinbaseCdpTokenRequestInput,
    /// The Stripe Privy token request.
    stripe_privy_token_request: ?StripePrivyTokenRequestInput,

    pub const json_field_names = .{
        .coinbase_cdp_token_request = "coinbaseCdpTokenRequest",
        .stripe_privy_token_request = "stripePrivyTokenRequest",
    };
};
