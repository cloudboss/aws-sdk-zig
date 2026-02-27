pub const DatasetStatus = enum {
    created,
    ingestion_in_progress,
    active,
    import_in_progress,

    pub const json_field_names = .{
        .created = "CREATED",
        .ingestion_in_progress = "INGESTION_IN_PROGRESS",
        .active = "ACTIVE",
        .import_in_progress = "IMPORT_IN_PROGRESS",
    };
};
