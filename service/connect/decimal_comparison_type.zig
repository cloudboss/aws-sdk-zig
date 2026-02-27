pub const DecimalComparisonType = enum {
    greater_or_equal,
    greater,
    lesser_or_equal,
    lesser,
    equal,
    not_equal,
    range,

    pub const json_field_names = .{
        .greater_or_equal = "GREATER_OR_EQUAL",
        .greater = "GREATER",
        .lesser_or_equal = "LESSER_OR_EQUAL",
        .lesser = "LESSER",
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
        .range = "RANGE",
    };
};
