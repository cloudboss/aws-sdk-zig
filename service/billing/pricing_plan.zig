const PricingPlanTier = @import("pricing_plan_tier.zig").PricingPlanTier;

/// A pricing plan for Enterprise Support billing.
pub const PricingPlan = struct {
    /// A description of the pricing plan.
    description: ?[]const u8 = null,

    /// Whether the discount applies to the minimum Support charge.
    discount_applies_to_minimum_charge: ?bool = null,

    /// The end date of the pricing plan.
    end_date: ?i64 = null,

    /// The minimum Support charge amount for this pricing plan.
    minimum_charge: ?[]const u8 = null,

    /// The name of the pricing plan.
    name: ?[]const u8 = null,

    /// The discount percentage applied by this pricing plan.
    plan_discount_percent: ?[]const u8 = null,

    /// The unique identifier for the pricing plan.
    pricing_plan_id: ?[]const u8 = null,

    /// The start date of the pricing plan.
    start_date: ?i64 = null,

    /// Whether the pricing plan uses tiered pricing.
    tiered: ?[]const u8 = null,

    /// The pricing tiers within this plan.
    tiers: []const PricingPlanTier,

    pub const json_field_names = .{
        .description = "description",
        .discount_applies_to_minimum_charge = "discountAppliesToMinimumCharge",
        .end_date = "endDate",
        .minimum_charge = "minimumCharge",
        .name = "name",
        .plan_discount_percent = "planDiscountPercent",
        .pricing_plan_id = "pricingPlanId",
        .start_date = "startDate",
        .tiered = "tiered",
        .tiers = "tiers",
    };
};
