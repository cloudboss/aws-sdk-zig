pub const ThresholdComparator = enum {
    greater_than,
    greater_than_or_equal_to,

    pub const json_field_names = .{
        .greater_than = "GREATER_THAN",
        .greater_than_or_equal_to = "GREATER_THAN_OR_EQUAL_TO",
    };
};
