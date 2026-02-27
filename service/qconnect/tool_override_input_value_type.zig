pub const ToolOverrideInputValueType = enum {
    string,
    number,
    json_string,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
        .json_string = "JSON_STRING",
    };
};
