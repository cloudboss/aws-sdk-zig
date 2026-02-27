pub const SavingsEstimationMode = enum {
    before_discounts,
    after_discounts,

    pub const json_field_names = .{
        .before_discounts = "BEFORE_DISCOUNTS",
        .after_discounts = "AFTER_DISCOUNTS",
    };
};
