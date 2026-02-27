pub const DataType = enum {
    string,
    integer,
    stringlist,
    stringmap,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .stringlist = "STRINGLIST",
        .stringmap = "STRINGMAP",
    };
};
