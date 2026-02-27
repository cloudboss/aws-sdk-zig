pub const Dimension = enum {
    savings_value,
    savings_value_after_discount,

    pub const json_field_names = .{
        .savings_value = "SAVINGS_VALUE",
        .savings_value_after_discount = "SAVINGS_VALUE_AFTER_DISCOUNT",
    };
};
