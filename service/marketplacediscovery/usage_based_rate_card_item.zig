const RateCardItem = @import("rate_card_item.zig").RateCardItem;

/// A rate card within a usage-based pricing term, containing per-unit rates.
pub const UsageBasedRateCardItem = struct {
    /// The per-unit rates for this usage-based rate card.
    rate_card: []const RateCardItem,

    pub const json_field_names = .{
        .rate_card = "rateCard",
    };
};
