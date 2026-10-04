/// A tier within an Enterprise Support pricing plan.
pub const PricingPlanTier = struct {
    /// The additional percentage applied to aggregate charges in this tier.
    additional_percentage_of_aggregate_charges: []const u8,

    /// The adjustment applied to aggregate charges.
    aggregate_charges_adjustment: []const u8,

    /// The base charge for this tier.
    base_charge: []const u8,

    /// The increment amount for incremental tier calculations.
    increment: ?[]const u8 = null,

    /// Whether the tier charges are calculated incrementally.
    incremental: bool,

    /// The charge per increment.
    increment_charge: ?[]const u8 = null,

    /// The maximum spend threshold for this tier.
    tier_maximum: ?[]const u8 = null,

    /// The minimum spend threshold for this tier.
    tier_minimum: []const u8,

    pub const json_field_names = .{
        .additional_percentage_of_aggregate_charges = "additionalPercentageOfAggregateCharges",
        .aggregate_charges_adjustment = "aggregateChargesAdjustment",
        .base_charge = "baseCharge",
        .increment = "increment",
        .incremental = "incremental",
        .increment_charge = "incrementCharge",
        .tier_maximum = "tierMaximum",
        .tier_minimum = "tierMinimum",
    };
};
