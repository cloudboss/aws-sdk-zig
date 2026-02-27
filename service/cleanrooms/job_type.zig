pub const JobType = enum {
    batch,
    incremental,
    delete_only,

    pub const json_field_names = .{
        .batch = "BATCH",
        .incremental = "INCREMENTAL",
        .delete_only = "DELETE_ONLY",
    };
};
