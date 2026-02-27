pub const NamedFilterType = enum {
    category_filter,
    numeric_equality_filter,
    numeric_range_filter,
    date_range_filter,
    relative_date_filter,
    null_filter,

    pub const json_field_names = .{
        .category_filter = "CATEGORY_FILTER",
        .numeric_equality_filter = "NUMERIC_EQUALITY_FILTER",
        .numeric_range_filter = "NUMERIC_RANGE_FILTER",
        .date_range_filter = "DATE_RANGE_FILTER",
        .relative_date_filter = "RELATIVE_DATE_FILTER",
        .null_filter = "NULL_FILTER",
    };
};
