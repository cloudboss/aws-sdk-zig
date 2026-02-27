pub const UpdateReason = enum {
    default,
    pricing_tier_update,
    entity_count_update,
    pricing_mode_update,
    overwritten,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .pricing_tier_update = "PRICING_TIER_UPDATE",
        .entity_count_update = "ENTITY_COUNT_UPDATE",
        .pricing_mode_update = "PRICING_MODE_UPDATE",
        .overwritten = "OVERWRITTEN",
    };
};
