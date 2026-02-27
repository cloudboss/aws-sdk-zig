pub const IngestionJobSortByAttribute = enum {
    status,
    started_at,

    pub const json_field_names = .{
        .status = "STATUS",
        .started_at = "STARTED_AT",
    };
};
