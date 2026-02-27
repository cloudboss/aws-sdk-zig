/// Information about the data migration run, including start and stop time,
/// latency, and
/// migration progress.
pub const DataMigrationStatistics = struct {
    /// The current latency of the change data capture (CDC) operation.
    cdc_latency: i32 = 0,

    /// The elapsed duration of the data migration run.
    elapsed_time_millis: i64 = 0,

    /// The data migration's progress in the full-load migration phase.
    full_load_percentage: i32 = 0,

    /// The time when the migration started.
    start_time: ?i64,

    /// The time when the migration stopped or failed.
    stop_time: ?i64,

    /// The number of tables that DMS failed to process.
    tables_errored: i32 = 0,

    /// The number of tables loaded in the current data migration run.
    tables_loaded: i32 = 0,

    /// The data migration's table loading progress.
    tables_loading: i32 = 0,

    /// The number of tables that are waiting for processing.
    tables_queued: i32 = 0,

    pub const json_field_names = .{
        .cdc_latency = "CDCLatency",
        .elapsed_time_millis = "ElapsedTimeMillis",
        .full_load_percentage = "FullLoadPercentage",
        .start_time = "StartTime",
        .stop_time = "StopTime",
        .tables_errored = "TablesErrored",
        .tables_loaded = "TablesLoaded",
        .tables_loading = "TablesLoading",
        .tables_queued = "TablesQueued",
    };
};
