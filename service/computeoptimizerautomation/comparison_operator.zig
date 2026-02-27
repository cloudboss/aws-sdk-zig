pub const ComparisonOperator = enum {
    string_equals,
    string_not_equals,
    string_equals_ignore_case,
    string_not_equals_ignore_case,
    string_like,
    string_not_like,
    numeric_equals,
    numeric_not_equals,
    numeric_less_than,
    numeric_less_than_equals,
    numeric_greater_than,
    numeric_greater_than_equals,

    pub const json_field_names = .{
        .string_equals = "STRING_EQUALS",
        .string_not_equals = "STRING_NOT_EQUALS",
        .string_equals_ignore_case = "STRING_EQUALS_IGNORE_CASE",
        .string_not_equals_ignore_case = "STRING_NOT_EQUALS_IGNORE_CASE",
        .string_like = "STRING_LIKE",
        .string_not_like = "STRING_NOT_LIKE",
        .numeric_equals = "NUMERIC_EQUALS",
        .numeric_not_equals = "NUMERIC_NOT_EQUALS",
        .numeric_less_than = "NUMERIC_LESS_THAN",
        .numeric_less_than_equals = "NUMERIC_LESS_THAN_EQUALS",
        .numeric_greater_than = "NUMERIC_GREATER_THAN",
        .numeric_greater_than_equals = "NUMERIC_GREATER_THAN_EQUALS",
    };
};
