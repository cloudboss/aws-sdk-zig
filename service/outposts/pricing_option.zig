const QuotePricingType = @import("quote_pricing_type.zig").QuotePricingType;
const SubscriptionPricingDetails = @import("subscription_pricing_details.zig").SubscriptionPricingDetails;

/// A pricing option for the specified Outpost.
pub const PricingOption = struct {
    /// The type of pricing model.
    pricing_type: ?QuotePricingType = null,

    /// The subscription pricing details for this pricing option.
    subscription_pricing_details: ?SubscriptionPricingDetails = null,

    pub const json_field_names = .{
        .pricing_type = "PricingType",
        .subscription_pricing_details = "SubscriptionPricingDetails",
    };
};
