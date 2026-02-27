pub const NumberAttributeBoostingType = enum {
    prioritize_larger_values,
    prioritize_smaller_values,

    pub const json_field_names = .{
        .prioritize_larger_values = "PRIORITIZE_LARGER_VALUES",
        .prioritize_smaller_values = "PRIORITIZE_SMALLER_VALUES",
    };
};
