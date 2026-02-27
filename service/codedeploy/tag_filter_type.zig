pub const TagFilterType = enum {
    key_only,
    value_only,
    key_and_value,

    pub const json_field_names = .{
        .key_only = "KEY_ONLY",
        .value_only = "VALUE_ONLY",
        .key_and_value = "KEY_AND_VALUE",
    };
};
