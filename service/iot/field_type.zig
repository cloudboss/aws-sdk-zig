pub const FieldType = enum {
    number,
    string,
    boolean,

    pub const json_field_names = .{
        .number = "NUMBER",
        .string = "STRING",
        .boolean = "BOOLEAN",
    };
};
