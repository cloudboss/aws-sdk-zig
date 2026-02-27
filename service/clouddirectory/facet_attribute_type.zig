pub const FacetAttributeType = enum {
    string,
    binary,
    boolean,
    number,
    datetime,
    variant,

    pub const json_field_names = .{
        .string = "STRING",
        .binary = "BINARY",
        .boolean = "BOOLEAN",
        .number = "NUMBER",
        .datetime = "DATETIME",
        .variant = "VARIANT",
    };
};
