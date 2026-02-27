pub const CommandParameterType = enum {
    string,
    integer,
    double,
    long,
    unsignedlong,
    boolean,
    binary,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .double = "DOUBLE",
        .long = "LONG",
        .unsignedlong = "UNSIGNEDLONG",
        .boolean = "BOOLEAN",
        .binary = "BINARY",
    };
};
