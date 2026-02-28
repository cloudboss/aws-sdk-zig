pub const ParamType = enum {
    str,
    int,
    float,
    complex,
    bool,
    list,
    @"null",

    pub const json_field_names = .{
        .str = "STR",
        .int = "INT",
        .float = "FLOAT",
        .complex = "COMPLEX",
        .bool = "BOOL",
        .list = "LIST",
        .@"null" = "NULL",
    };
};
