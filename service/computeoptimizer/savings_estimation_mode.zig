pub const SavingsEstimationMode = enum {
    after_discounts,
    before_discounts,

    pub const json_field_names = .{
        .after_discounts = "AFTER_DISCOUNTS",
        .before_discounts = "BEFORE_DISCOUNTS",
    };
};
