pub const ResourceSubType = enum {
    database,
    process,
    database_process,

    pub const json_field_names = .{
        .database = "DATABASE",
        .process = "PROCESS",
        .database_process = "DATABASE_PROCESS",
    };
};
