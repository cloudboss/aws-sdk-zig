/// Provides the task status showing a running total of the total number of
/// files to be processed,
/// the number successfully processed, and the number of files the task failed
/// to process.
pub const DataRepositoryTaskStatus = struct {
    /// A running total of the number of files that the task failed to process.
    failed_count: ?i64 = null,

    /// The time at which the task status was last updated.
    last_updated_time: ?i64 = null,

    /// The total amount of data, in GiB, released by an Amazon File Cache
    /// AUTO_RELEASE_DATA task that automatically releases files from the cache.
    released_capacity: ?i64 = null,

    /// A running total of the number of files that the task has successfully
    /// processed.
    succeeded_count: ?i64 = null,

    /// The total number of files that the task will process. While a task is
    /// executing, the sum of
    /// `SucceededCount` plus `FailedCount` may not equal `TotalCount`. When the
    /// task is complete,
    /// `TotalCount` equals the sum of `SucceededCount` plus `FailedCount`.
    total_count: ?i64 = null,

    pub const json_field_names = .{
        .failed_count = "FailedCount",
        .last_updated_time = "LastUpdatedTime",
        .released_capacity = "ReleasedCapacity",
        .succeeded_count = "SucceededCount",
        .total_count = "TotalCount",
    };
};
