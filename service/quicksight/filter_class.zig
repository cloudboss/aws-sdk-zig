pub const FilterClass = enum {
    enforced_value_filter,
    conditional_value_filter,
    named_value_filter,

    pub const json_field_names = .{
        .enforced_value_filter = "ENFORCED_VALUE_FILTER",
        .conditional_value_filter = "CONDITIONAL_VALUE_FILTER",
        .named_value_filter = "NAMED_VALUE_FILTER",
    };
};
