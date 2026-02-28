pub const RetrievalResultContentColumnType = enum {
    blob,
    boolean,
    double,
    @"null",
    long,
    string,

    pub const json_field_names = .{
        .blob = "BLOB",
        .boolean = "BOOLEAN",
        .double = "DOUBLE",
        .@"null" = "NULL",
        .long = "LONG",
        .string = "STRING",
    };
};
