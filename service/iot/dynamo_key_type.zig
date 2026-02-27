pub const DynamoKeyType = enum {
    string,
    number,

    pub const json_field_names = .{
        .string = "STRING",
        .number = "NUMBER",
    };
};
