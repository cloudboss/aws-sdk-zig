pub const DataSourceSyncJobStatus = enum {
    failed,
    succeeded,
    syncing,
    incomplete,
    stopping,
    aborted,
    syncing_indexing,

    pub const json_field_names = .{
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .syncing = "SYNCING",
        .incomplete = "INCOMPLETE",
        .stopping = "STOPPING",
        .aborted = "ABORTED",
        .syncing_indexing = "SYNCING_INDEXING",
    };
};
