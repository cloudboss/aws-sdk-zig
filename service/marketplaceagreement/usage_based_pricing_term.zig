const UsageBasedRateCardItem = @import("usage_based_rate_card_item.zig").UsageBasedRateCardItem;

/// Defines a usage-based pricing model (typically, pay-as-you-go pricing),
/// where the customers are charged based on product usage.
pub const UsageBasedPricingTerm = struct {
    /// Defines the currency for the prices mentioned in the term.
    currency_code: ?[]const u8,

    /// List of rate cards.
    rate_cards: ?[]const UsageBasedRateCardItem,

    /// Category of the term.
    type: ?[]const u8,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .rate_cards = "rateCards",
        .type = "type",
    };
};
