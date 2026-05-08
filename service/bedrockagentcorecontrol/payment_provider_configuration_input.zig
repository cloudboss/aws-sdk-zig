const CoinbaseCdpConfigurationInput = @import("coinbase_cdp_configuration_input.zig").CoinbaseCdpConfigurationInput;
const StripePrivyConfigurationInput = @import("stripe_privy_configuration_input.zig").StripePrivyConfigurationInput;

/// PROVIDER CONFIGURATION INPUT - Contains secrets for creation/update
pub const PaymentProviderConfigurationInput = union(enum) {
    coinbase_cdp_configuration: ?CoinbaseCdpConfigurationInput,
    stripe_privy_configuration: ?StripePrivyConfigurationInput,

    pub const json_field_names = .{
        .coinbase_cdp_configuration = "coinbaseCdpConfiguration",
        .stripe_privy_configuration = "stripePrivyConfiguration",
    };
};
