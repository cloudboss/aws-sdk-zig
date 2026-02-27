pub const DataLakeDatasetSchemaFieldType = enum {
    int,
    double,
    string,
    timestamp,
    long,

    pub const json_field_names = .{
        .int = "INT",
        .double = "DOUBLE",
        .string = "STRING",
        .timestamp = "TIMESTAMP",
        .long = "LONG",
    };
};
