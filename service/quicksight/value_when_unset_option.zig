pub const ValueWhenUnsetOption = enum {
    recommended_value,
    null,

    pub const json_field_names = .{
        .recommended_value = "RECOMMENDED_VALUE",
        .null = "NULL",
    };
};
