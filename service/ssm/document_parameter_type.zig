pub const DocumentParameterType = enum {
    string,
    string_list,

    pub const json_field_names = .{
        .string = "String",
        .string_list = "StringList",
    };
};
