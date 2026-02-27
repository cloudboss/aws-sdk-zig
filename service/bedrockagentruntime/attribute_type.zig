pub const AttributeType = enum {
    string,
    number,
    boolean,
    string_list,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
        .boolean = "BOOLEAN",
        .string_list = "STRING_LIST",
    };
};
