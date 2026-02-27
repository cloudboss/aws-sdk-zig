pub const DataSetDateComparisonFilterOperator = enum {
    before,
    before_or_equals_to,
    after,
    after_or_equals_to,

    pub const json_field_names = .{
        .before = "BEFORE",
        .before_or_equals_to = "BEFORE_OR_EQUALS_TO",
        .after = "AFTER",
        .after_or_equals_to = "AFTER_OR_EQUALS_TO",
    };
};
