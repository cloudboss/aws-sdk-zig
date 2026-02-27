pub const ColumnDataType = enum {
    string,
    integer,
    decimal,
    datetime,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .decimal = "DECIMAL",
        .datetime = "DATETIME",
    };
};
