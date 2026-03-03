const Constraints = @import("constraints.zig").Constraints;
const RateCardItem = @import("rate_card_item.zig").RateCardItem;
const Selector = @import("selector.zig").Selector;

/// Within the prepaid payment model defined under
/// `ConfigurableUpfrontPricingTerm`, the `RateCardItem` defines all the various
/// rate cards (including pricing and dimensions) that have been proposed.
pub const ConfigurableUpfrontRateCardItem = struct {
    /// Defines limits on how the term can be configured by acceptors.
    constraints: ?Constraints = null,

    /// Defines the per unit rates for product dimensions.
    rate_card: ?[]const RateCardItem = null,

    /// Differentiates between the mutually exclusive rate cards in the same pricing
    /// term to be selected by the buyer.
    selector: ?Selector = null,

    pub const json_field_names = .{
        .constraints = "constraints",
        .rate_card = "rateCard",
        .selector = "selector",
    };
};
