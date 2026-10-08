const Constraints = @import("constraints.zig").Constraints;
const RateCardItem = @import("rate_card_item.zig").RateCardItem;
const Selector = @import("selector.zig").Selector;

/// A rate card item within a configurable upfront pricing term, including a
/// selector for choosing the configuration and per-unit rates.
pub const ConfigurableUpfrontRateCardItem = struct {
    /// Constraints on how the buyer can configure this rate card, such as whether
    /// multiple dimensions can be selected.
    constraints: Constraints,

    /// The per-unit rates for this configuration.
    rate_card: []const RateCardItem,

    /// The selector criteria for this rate card, such as duration.
    selector: Selector,

    pub const json_field_names = .{
        .constraints = "constraints",
        .rate_card = "rateCard",
        .selector = "selector",
    };
};
