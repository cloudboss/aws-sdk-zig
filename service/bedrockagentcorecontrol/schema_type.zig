pub const SchemaType = enum {
    string,
    number,
    object,
    array,
    boolean,
    integer,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
        .object = "OBJECT",
        .array = "ARRAY",
        .boolean = "BOOLEAN",
        .integer = "INTEGER",
    };
};
