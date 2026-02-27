pub const GlueRecordType = enum {
    date,
    string,
    timestamp,
    int,
    float,
    long,
    bigdecimal,
    byte,
    short,
    double,

    pub const json_field_names = .{
        .date = "DATE",
        .string = "STRING",
        .timestamp = "TIMESTAMP",
        .int = "INT",
        .float = "FLOAT",
        .long = "LONG",
        .bigdecimal = "BIGDECIMAL",
        .byte = "BYTE",
        .short = "SHORT",
        .double = "DOUBLE",
    };
};
