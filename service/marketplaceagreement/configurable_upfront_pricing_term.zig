const ConfigurableUpfrontPricingTermConfiguration = @import("configurable_upfront_pricing_term_configuration.zig").ConfigurableUpfrontPricingTermConfiguration;
const ConfigurableUpfrontRateCardItem = @import("configurable_upfront_rate_card_item.zig").ConfigurableUpfrontRateCardItem;

/// Defines a prepaid payment model that allows buyers to configure the
/// entitlements they want to purchase and the duration.
pub const ConfigurableUpfrontPricingTerm = struct {
    /// Additional parameters specified by the acceptor while accepting the term.
    configuration: ?ConfigurableUpfrontPricingTermConfiguration,

    /// Defines the currency for the prices mentioned in the term.
    currency_code: ?[]const u8,

    /// A rate card defines the per unit rates for product dimensions.
    rate_cards: ?[]const ConfigurableUpfrontRateCardItem,

    /// Category of selector.
    type: ?[]const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .currency_code = "currencyCode",
        .rate_cards = "rateCards",
        .type = "type",
    };
};
