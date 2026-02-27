pub const ProvisionedControlPlaneTier = enum {
    standard,
    tier_xl,
    tier_2_xl,
    tier_4_xl,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .tier_xl = "TIER_XL",
        .tier_2_xl = "TIER_2XL",
        .tier_4_xl = "TIER_4XL",
    };
};
