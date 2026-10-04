const CoinbaseCdpConfigurationInput = @import("coinbase_cdp_configuration_input.zig").CoinbaseCdpConfigurationInput;
const StripePrivyConfigurationInput = @import("stripe_privy_configuration_input.zig").StripePrivyConfigurationInput;

/// Provider configuration input — contains secrets for creation and update.
/// Varies by vendor type.
pub const PaymentProviderConfigurationInput = union(enum) {
    /// The Coinbase CDP configuration.
    coinbase_cdp_configuration: ?CoinbaseCdpConfigurationInput,
    /// The Stripe Privy configuration.
    stripe_privy_configuration: ?StripePrivyConfigurationInput,

    pub const json_field_names = .{
        .coinbase_cdp_configuration = "coinbaseCdpConfiguration",
        .stripe_privy_configuration = "stripePrivyConfiguration",
    };
};
