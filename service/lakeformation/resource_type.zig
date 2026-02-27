pub const ResourceType = enum {
    database,
    table,

    pub const json_field_names = .{
        .database = "DATABASE",
        .table = "TABLE",
    };
};
