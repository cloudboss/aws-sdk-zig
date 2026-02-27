const RateCardItem = @import("rate_card_item.zig").RateCardItem;

/// Within the pay-as-you-go model defined under `UsageBasedPricingTerm`, the
/// `UsageBasedRateCardItem` defines an individual rate for a product dimension.
pub const UsageBasedRateCardItem = struct {
    /// Defines the per unit rates for product dimensions.
    rate_card: ?[]const RateCardItem,

    pub const json_field_names = .{
        .rate_card = "rateCard",
    };
};
