const CoinbaseCdpConfigurationOutput = @import("coinbase_cdp_configuration_output.zig").CoinbaseCdpConfigurationOutput;
const StripePrivyConfigurationOutput = @import("stripe_privy_configuration_output.zig").StripePrivyConfigurationOutput;

/// Provider configuration output — no raw secrets, only ARNs. Varies by vendor
/// type.
pub const PaymentProviderConfigurationOutput = union(enum) {
    /// The Coinbase CDP configuration.
    coinbase_cdp_configuration: ?CoinbaseCdpConfigurationOutput,
    /// The Stripe Privy configuration.
    stripe_privy_configuration: ?StripePrivyConfigurationOutput,

    pub const json_field_names = .{
        .coinbase_cdp_configuration = "coinbaseCdpConfiguration",
        .stripe_privy_configuration = "stripePrivyConfiguration",
    };
};
