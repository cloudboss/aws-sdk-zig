pub const ParameterType = enum {
    string,
    string_list,
    secure_string,

    pub const json_field_names = .{
        .string = "STRING",
        .string_list = "STRING_LIST",
        .secure_string = "SECURE_STRING",
    };
};
