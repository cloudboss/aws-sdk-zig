pub const AttributeDataType = enum {
    string,
    number,
    datetime,
    boolean,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
        .datetime = "DATETIME",
        .boolean = "BOOLEAN",
    };
};
