pub const TemplateParameterDataType = enum {
    number,
    string,

    pub const json_field_names = .{
        .number = "NUMBER",
        .string = "STRING",
    };
};
