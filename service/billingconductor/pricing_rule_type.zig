pub const PricingRuleType = enum {
    markup,
    discount,
    tiering,

    pub const json_field_names = .{
        .markup = "MARKUP",
        .discount = "DISCOUNT",
        .tiering = "TIERING",
    };
};
