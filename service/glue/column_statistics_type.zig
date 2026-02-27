pub const ColumnStatisticsType = enum {
    boolean,
    date,
    decimal,
    double,
    long,
    string,
    binary,

    pub const json_field_names = .{
        .boolean = "BOOLEAN",
        .date = "DATE",
        .decimal = "DECIMAL",
        .double = "DOUBLE",
        .long = "LONG",
        .string = "STRING",
        .binary = "BINARY",
    };
};
