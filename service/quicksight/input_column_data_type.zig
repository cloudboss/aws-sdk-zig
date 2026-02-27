pub const InputColumnDataType = enum {
    string,
    integer,
    decimal,
    datetime,
    bit,
    boolean,
    json,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .decimal = "DECIMAL",
        .datetime = "DATETIME",
        .bit = "BIT",
        .boolean = "BOOLEAN",
        .json = "JSON",
    };
};
