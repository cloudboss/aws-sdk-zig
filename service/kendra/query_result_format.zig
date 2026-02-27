pub const QueryResultFormat = enum {
    table,
    text,

    pub const json_field_names = .{
        .table = "TABLE",
        .text = "TEXT",
    };
};
