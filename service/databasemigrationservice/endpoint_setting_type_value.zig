pub const EndpointSettingTypeValue = enum {
    string,
    boolean,
    integer,
    @"enum",

    pub const json_field_names = .{
        .string = "STRING",
        .boolean = "BOOLEAN",
        .integer = "INTEGER",
        .@"enum" = "ENUM",
    };
};
