const CoinbaseCdpConfigurationOutput = @import("coinbase_cdp_configuration_output.zig").CoinbaseCdpConfigurationOutput;
const StripePrivyConfigurationOutput = @import("stripe_privy_configuration_output.zig").StripePrivyConfigurationOutput;

/// PROVIDER CONFIGURATION OUTPUT - No raw secrets, only ARNs
pub const PaymentProviderConfigurationOutput = union(enum) {
    coinbase_cdp_configuration: ?CoinbaseCdpConfigurationOutput,
    stripe_privy_configuration: ?StripePrivyConfigurationOutput,

    pub const json_field_names = .{
        .coinbase_cdp_configuration = "coinbaseCdpConfiguration",
        .stripe_privy_configuration = "stripePrivyConfiguration",
    };
};
