const ConfigurableUpfrontRateCardItem = @import("configurable_upfront_rate_card_item.zig").ConfigurableUpfrontRateCardItem;
const TermType = @import("term_type.zig").TermType;

/// Defines a configurable upfront pricing term with selectable rate cards,
/// where buyers choose from predefined pricing configurations.
pub const ConfigurableUpfrontPricingTerm = struct {
    /// Defines the currency for the prices in this term.
    currency_code: []const u8,

    /// The unique identifier of the term.
    id: []const u8,

    /// The rate cards available for selection, each with a selector, constraints,
    /// and per-unit rates.
    rate_cards: ?[]const ConfigurableUpfrontRateCardItem = null,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .id = "id",
        .rate_cards = "rateCards",
        .type = "type",
    };
};
