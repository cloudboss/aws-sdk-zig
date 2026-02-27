pub const Type = enum {
    string,
    number,
    integer,
    boolean,
    array,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
        .integer = "INTEGER",
        .boolean = "BOOLEAN",
        .array = "ARRAY",
    };
};
