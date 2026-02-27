pub const PropertyDataType = enum {
    string,
    integer,
    double,
    boolean,
    @"struct",

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .double = "DOUBLE",
        .boolean = "BOOLEAN",
        .@"struct" = "STRUCT",
    };
};
