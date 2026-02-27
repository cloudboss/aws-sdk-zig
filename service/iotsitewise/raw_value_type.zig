pub const RawValueType = enum {
    double,
    boolean,
    string,
    integer,
    unknown,

    pub const json_field_names = .{
        .double = "DOUBLE",
        .boolean = "BOOLEAN",
        .string = "STRING",
        .integer = "INTEGER",
        .unknown = "UNKNOWN",
    };
};
