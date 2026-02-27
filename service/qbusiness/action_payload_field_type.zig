pub const ActionPayloadFieldType = enum {
    string,
    number,
    array,
    boolean,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
        .array = "ARRAY",
        .boolean = "BOOLEAN",
    };
};
