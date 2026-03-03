/// This object provides a collection of statistics about a serverless
/// replication.
pub const ReplicationStats = struct {
    /// The elapsed time of the replication, in milliseconds.
    elapsed_time_millis: i64 = 0,

    /// The date the replication was started either with a fresh start or a target
    /// reload.
    fresh_start_date: ?i64 = null,

    /// The date the replication full load was finished.
    full_load_finish_date: ?i64 = null,

    /// The percent complete for the full load serverless replication.
    full_load_progress_percent: i32 = 0,

    /// The date the replication full load was started.
    full_load_start_date: ?i64 = null,

    /// The date the replication is scheduled to start.
    start_date: ?i64 = null,

    /// The date the replication was stopped.
    stop_date: ?i64 = null,

    /// The number of errors that have occured for this replication.
    tables_errored: i32 = 0,

    /// The number of tables loaded for this replication.
    tables_loaded: i32 = 0,

    /// The number of tables currently loading for this replication.
    tables_loading: i32 = 0,

    /// The number of tables queued for this replication.
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
