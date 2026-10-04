/// A tier-level charge within a Business Support pricing plan. Business Support
/// uses tiered pricing where different percentage rates apply to different
/// ranges of Support-eligible spend.
pub const BusinessSupportTierCharge = struct {
    /// The end date of the charge period for this tier charge.
    charge_period_end_date: ?i64 = null,

    /// The start date of the charge period for this tier charge.
    charge_period_start_date: ?i64 = null,

    /// The Business Support charge amount calculated for this pricing tier.
    tier_charge: []const u8,

    /// A human-readable description of the pricing tier, including the spend range
    /// and percentage rate applied.
    tier_description: []const u8,

    /// The percentage rate applied to Support-eligible spend within this pricing
    /// tier.
    tier_rate: []const u8,

    /// The amount of Support-eligible spend that falls within this pricing tier.
    usage_slice: []const u8,

    pub const json_field_names = .{
        .charge_period_end_date = "chargePeriodEndDate",
        .charge_period_start_date = "chargePeriodStartDate",
        .tier_charge = "tierCharge",
        .tier_description = "tierDescription",
        .tier_rate = "tierRate",
        .usage_slice = "usageSlice",
    };
};
