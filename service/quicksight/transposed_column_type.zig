pub const TransposedColumnType = enum {
    row_header_column,
    value_column,

    pub const json_field_names = .{
        .row_header_column = "ROW_HEADER_COLUMN",
        .value_column = "VALUE_COLUMN",
    };
};
