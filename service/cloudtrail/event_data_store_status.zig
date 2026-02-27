pub const EventDataStoreStatus = enum {
    created,
    enabled,
    pending_deletion,
    starting_ingestion,
    stopping_ingestion,
    stopped_ingestion,

    pub const json_field_names = .{
        .created = "CREATED",
        .enabled = "ENABLED",
        .pending_deletion = "PENDING_DELETION",
        .starting_ingestion = "STARTING_INGESTION",
        .stopping_ingestion = "STOPPING_INGESTION",
        .stopped_ingestion = "STOPPED_INGESTION",
    };
};
