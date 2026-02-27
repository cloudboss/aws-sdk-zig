pub const RangeMode = enum {
    first,
    last,
    last_before_missing_values,
    inclusive,
    exclusive,

    pub const json_field_names = .{
        .first = "FIRST",
        .last = "LAST",
        .last_before_missing_values = "LAST_BEFORE_MISSING_VALUES",
        .inclusive = "INCLUSIVE",
        .exclusive = "EXCLUSIVE",
    };
};
