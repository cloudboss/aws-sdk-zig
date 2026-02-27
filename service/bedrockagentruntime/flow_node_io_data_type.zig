pub const FlowNodeIODataType = enum {
    string,
    number,
    boolean,
    object,
    array,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
        .boolean = "BOOLEAN",
        .object = "OBJECT",
        .array = "ARRAY",
    };
};
