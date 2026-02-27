pub const PricingTier = enum {
    tier_1,
    tier_2,
    tier_3,
    tier_4,

    pub const json_field_names = .{
        .tier_1 = "TIER_1",
        .tier_2 = "TIER_2",
        .tier_3 = "TIER_3",
        .tier_4 = "TIER_4",
    };
};
