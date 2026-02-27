pub const Type = enum {
    relationship,
    string,
    long,
    boolean,
    integer,
    double,
    list,
    map,

    pub const json_field_names = .{
        .relationship = "RELATIONSHIP",
        .string = "STRING",
        .long = "LONG",
        .boolean = "BOOLEAN",
        .integer = "INTEGER",
        .double = "DOUBLE",
        .list = "LIST",
        .map = "MAP",
    };
};
