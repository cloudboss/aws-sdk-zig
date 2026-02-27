pub const PricingMode = enum {
    basic,
    standard,
    tiered_bundle,

    pub const json_field_names = .{
        .basic = "BASIC",
        .standard = "STANDARD",
        .tiered_bundle = "TIERED_BUNDLE",
    };
};
