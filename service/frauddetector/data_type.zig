pub const DataType = enum {
    string,
    integer,
    float,
    boolean,
    datetime,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .float = "FLOAT",
        .boolean = "BOOLEAN",
        .datetime = "DATETIME",
    };
};
