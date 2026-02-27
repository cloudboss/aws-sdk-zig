pub const SyncMetadataStatus = enum {
    created,
    running,
    failed,
    partially_failed,
    succeeded,

    pub const json_field_names = .{
        .created = "CREATED",
        .running = "RUNNING",
        .failed = "FAILED",
        .partially_failed = "PARTIALLY_FAILED",
        .succeeded = "SUCCEEDED",
    };
};
