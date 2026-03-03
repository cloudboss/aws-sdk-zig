/// In response to a request by the `DescribeReplicationTasks` operation, this
/// object provides a collection of statistics about a replication task.
pub const ReplicationTaskStats = struct {
    /// The elapsed time of the task, in milliseconds.
    elapsed_time_millis: i64 = 0,

    /// The date the replication task was started either with a fresh start or a
    /// target
    /// reload.
    fresh_start_date: ?i64 = null,

    /// The date the replication task full load was completed.
    full_load_finish_date: ?i64 = null,

    /// The percent complete for the full load migration task.
    full_load_progress_percent: i32 = 0,

    /// The date the replication task full load was started.
    full_load_start_date: ?i64 = null,

    /// The date the replication task was started either with a fresh start or a
    /// resume. For
    /// more information, see
    /// [StartReplicationTaskType](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTask.html#DMS-StartReplicationTask-request-StartReplicationTaskType).
    start_date: ?i64 = null,

    /// The date the replication task was stopped.
    stop_date: ?i64 = null,

    /// The number of errors that have occurred during this task.
    tables_errored: i32 = 0,

    /// The number of tables loaded for this task.
    tables_loaded: i32 = 0,

    /// The number of tables currently loading for this task.
    tables_loading: i32 = 0,

    /// The number of tables queued for this task.
    tables_queued: i32 = 0,

    pub const json_field_names = .{
        .elapsed_time_millis = "ElapsedTimeMillis",
        .fresh_start_date = "FreshStartDate",
        .full_load_finish_date = "FullLoadFinishDate",
        .full_load_progress_percent = "FullLoadProgressPercent",
        .full_load_start_date = "FullLoadStartDate",
        .start_date = "StartDate",
        .stop_date = "StopDate",
        .tables_errored = "TablesErrored",
        .tables_loaded = "TablesLoaded",
        .tables_loading = "TablesLoading",
        .tables_queued = "TablesQueued",
    };
};
