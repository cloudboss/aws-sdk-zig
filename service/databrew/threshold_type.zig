pub const ThresholdType = enum {
    greater_than_or_equal,
    less_than_or_equal,
    greater_than,
    less_than,

    pub const json_field_names = .{
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
        .less_than_or_equal = "LESS_THAN_OR_EQUAL",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
    };
};
