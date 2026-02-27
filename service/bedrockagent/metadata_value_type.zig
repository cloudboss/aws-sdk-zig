pub const MetadataValueType = enum {
    boolean,
    number,
    string,
    string_list,

    pub const json_field_names = .{
        .boolean = "BOOLEAN",
        .number = "NUMBER",
        .string = "STRING",
        .string_list = "STRING_LIST",
    };
};
