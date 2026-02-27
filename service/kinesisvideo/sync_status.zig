pub const SyncStatus = enum {
    syncing,
    acknowledged,
    in_sync,
    sync_failed,
    deleting,
    delete_failed,
    deleting_acknowledged,

    pub const json_field_names = .{
        .syncing = "SYNCING",
        .acknowledged = "ACKNOWLEDGED",
        .in_sync = "IN_SYNC",
        .sync_failed = "SYNC_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .deleting_acknowledged = "DELETING_ACKNOWLEDGED",
    };
};
