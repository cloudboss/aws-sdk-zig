pub const SavingsEstimationMode = enum {
    before_discount,
    after_discount,

    pub const json_field_names = .{
        .before_discount = "BEFORE_DISCOUNT",
        .after_discount = "AFTER_DISCOUNT",
    };
};
