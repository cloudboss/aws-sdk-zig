pub const Relation = enum {
    equal_to,
    greater_than_or_equal_to,

    pub const json_field_names = .{
        .equal_to = "EQUAL_TO",
        .greater_than_or_equal_to = "GREATER_THAN_OR_EQUAL_TO",
    };
};
