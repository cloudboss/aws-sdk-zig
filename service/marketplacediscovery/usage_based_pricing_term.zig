const UsageBasedRateCardItem = @import("usage_based_rate_card_item.zig").UsageBasedRateCardItem;
const TermType = @import("term_type.zig").TermType;

/// Defines a usage-based pricing term (typically pay-as-you-go), where buyers
/// are charged based on product usage.
pub const UsageBasedPricingTerm = struct {
    /// Defines the currency for the prices in this term.
    currency_code: []const u8,

    /// The unique identifier of the term.
    id: []const u8,

    /// The rate cards containing per-unit rates for usage-based pricing.
    rate_cards: []const UsageBasedRateCardItem,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .id = "id",
        .rate_cards = "rateCards",
        .type = "type",
    };
};
