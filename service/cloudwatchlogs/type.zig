pub const Type = enum {
    boolean,
    integer,
    double,
    string,

    pub const json_field_names = .{
        .boolean = "BOOLEAN",
        .integer = "INTEGER",
        .double = "DOUBLE",
        .string = "STRING",
    };
};
