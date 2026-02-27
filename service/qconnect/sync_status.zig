pub const SyncStatus = enum {
    sync_failed,
    syncing_in_progress,
    sync_success,
    create_in_progress,

    pub const json_field_names = .{
        .sync_failed = "SYNC_FAILED",
        .syncing_in_progress = "SYNCING_IN_PROGRESS",
        .sync_success = "SYNC_SUCCESS",
        .create_in_progress = "CREATE_IN_PROGRESS",
    };
};
