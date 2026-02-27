pub const ResourceSyncStatus = enum {
    /// A sync attempt has been created and will begin soon.
    initiated,
    /// Syncing has started and work is being done to reconcile state.
    in_progress,
    /// Syncing has completed successfully.
    succeeded,
    /// Syncing has failed.
    failed,

    pub const json_field_names = .{
        .initiated = "INITIATED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
