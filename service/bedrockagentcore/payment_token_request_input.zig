const CoinbaseCdpTokenRequestInput = @import("coinbase_cdp_token_request_input.zig").CoinbaseCdpTokenRequestInput;
const StripePrivyTokenRequestInput = @import("stripe_privy_token_request_input.zig").StripePrivyTokenRequestInput;

/// VENDOR-SPECIFIC TOKEN REQUEST CONFIGURATION - Input
pub const PaymentTokenRequestInput = union(enum) {
    coinbase_cdp_token_request: ?CoinbaseCdpTokenRequestInput,
    stripe_privy_token_request: ?StripePrivyTokenRequestInput,

    pub const json_field_names = .{
        .coinbase_cdp_token_request = "coinbaseCdpTokenRequest",
        .stripe_privy_token_request = "stripePrivyTokenRequest",
    };
};
