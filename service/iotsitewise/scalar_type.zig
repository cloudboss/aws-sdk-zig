pub const ScalarType = enum {
    boolean,
    int,
    double,
    timestamp,
    string,

    pub const json_field_names = .{
        .boolean = "BOOLEAN",
        .int = "INT",
        .double = "DOUBLE",
        .timestamp = "TIMESTAMP",
        .string = "STRING",
    };
};
