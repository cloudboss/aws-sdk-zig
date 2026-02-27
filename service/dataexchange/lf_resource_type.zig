pub const LFResourceType = enum {
    table,
    database,

    pub const json_field_names = .{
        .table = "TABLE",
        .database = "DATABASE",
    };
};
