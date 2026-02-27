pub const AttributeType = enum {
    string,
    string_list,
    number,
    date,

    pub const json_field_names = .{
        .string = "STRING",
        .string_list = "STRING_LIST",
        .number = "NUMBER",
        .date = "DATE",
    };
};
