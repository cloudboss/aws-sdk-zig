pub const RepositorySyncStatus = enum {
    /// A repository sync attempt has been created and will begin soon.
    initiated,
    /// A repository sync attempt has started and work is being done to reconcile
    /// the branch.
    in_progress,
    /// The repository sync attempt has completed successfully.
    succeeded,
    /// The repository sync attempt has failed.
    failed,
    /// The repository sync attempt didn't execute and was queued.
    queued,

    pub const json_field_names = .{
        .initiated = "INITIATED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .queued = "QUEUED",
    };
};
