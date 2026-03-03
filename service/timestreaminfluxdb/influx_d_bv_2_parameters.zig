const Duration = @import("duration.zig").Duration;
const LogLevel = @import("log_level.zig").LogLevel;
const TracingType = @import("tracing_type.zig").TracingType;

/// All the customer-modifiable InfluxDB v2 parameters in Timestream for
/// InfluxDB.
pub const InfluxDBv2Parameters = struct {
    /// Include option to show detailed logs for Flux queries.
    ///
    /// Default: false
    flux_log_enabled: ?bool = null,

    /// Maximum duration the server should keep established connections alive while
    /// waiting for new requests. Set to 0 for no timeout.
    ///
    /// Default: 3 minutes
    http_idle_timeout: ?Duration = null,

    /// Maximum duration the server should try to read HTTP headers for new
    /// requests. Set to 0 for no timeout.
    ///
    /// Default: 10 seconds
    http_read_header_timeout: ?Duration = null,

    /// Maximum duration the server should try to read the entirety of new requests.
    /// Set to 0 for no timeout.
    ///
    /// Default: 0
    http_read_timeout: ?Duration = null,

    /// Maximum duration the server should spend processing and responding to write
    /// requests. Set to 0 for no timeout.
    ///
    /// Default: 0
    http_write_timeout: ?Duration = null,

    /// Maximum number of group by time buckets a SELECT statement can create. 0
    /// allows an unlimited number of buckets.
    ///
    /// Default: 0
    influxql_max_select_buckets: ?i64 = null,

    /// Maximum number of points a SELECT statement can process. 0 allows an
    /// unlimited number of points. InfluxDB checks the point count every second (so
    /// queries exceeding the maximum aren’t immediately aborted).
    ///
    /// Default: 0
    influxql_max_select_point: ?i64 = null,

    /// Maximum number of series a SELECT statement can return. 0 allows an
    /// unlimited number of series.
    ///
    /// Default: 0
    influxql_max_select_series: ?i64 = null,

    /// Log output level. InfluxDB outputs log entries with severity levels greater
    /// than or equal to the level specified.
    ///
    /// Default: info
    log_level: ?LogLevel = null,

    /// Disable the HTTP /metrics endpoint which exposes [internal InfluxDB
    /// metrics](https://docs.influxdata.com/influxdb/v2/reference/internals/metrics/).
    ///
    /// Default: false
    metrics_disabled: ?bool = null,

    /// Disable the task scheduler. If problematic tasks prevent InfluxDB from
    /// starting, use this option to start InfluxDB without scheduling or executing
    /// tasks.
    ///
    /// Default: false
    no_tasks: ?bool = null,

    /// Disable the /debug/pprof HTTP endpoint. This endpoint provides runtime
    /// profiling data and can be helpful when debugging.
    ///
    /// Default: true
    pprof_disabled: ?bool = null,

    /// Number of queries allowed to execute concurrently. Setting to 0 allows an
    /// unlimited number of concurrent queries.
    ///
    /// Default: 0
    query_concurrency: ?i32 = null,

    /// Initial bytes of memory allocated for a query.
    ///
    /// Default: 0
    query_initial_memory_bytes: ?i64 = null,

    /// Maximum number of queries allowed in execution queue. When queue limit is
    /// reached, new queries are rejected. Setting to 0 allows an unlimited number
    /// of queries in the queue.
    ///
    /// Default: 0
    query_max_memory_bytes: ?i64 = null,

    /// Maximum bytes of memory allowed for a single query. Must be greater or equal
    /// to queryInitialMemoryBytes.
    ///
    /// Default: 0
    query_memory_bytes: ?i64 = null,

    /// Maximum number of queries allowed in execution queue. When queue limit is
    /// reached, new queries are rejected. Setting to 0 allows an unlimited number
    /// of queries in the queue.
    ///
    /// Default: 0
    query_queue_size: ?i32 = null,

    /// Specifies the Time to Live (TTL) in minutes for newly created user sessions.
    ///
    /// Default: 60
    session_length: ?i32 = null,

    /// Disables automatically extending a user’s session TTL on each request. By
    /// default, every request sets the session’s expiration time to five minutes
    /// from now. When disabled, sessions expire after the specified [session
    /// length](https://docs.influxdata.com/influxdb/v2/reference/config-options/#session-length) and the user is redirected to the login page, even if recently active.
    ///
    /// Default: false
    session_renew_disabled: ?bool = null,

    /// Maximum size (in bytes) a shard’s cache can reach before it starts rejecting
    /// writes. Must be greater than storageCacheSnapShotMemorySize and lower than
    /// instance’s total memory capacity. We recommend setting it to below 15% of
    /// the total memory capacity.
    ///
    /// Default: 1073741824
    storage_cache_max_memory_size: ?i64 = null,

    /// Size (in bytes) at which the storage engine will snapshot the cache and
    /// write it to a TSM file to make more memory available. Must not be greater
    /// than storageCacheMaxMemorySize.
    ///
    /// Default: 26214400
    storage_cache_snapshot_memory_size: ?i64 = null,

    /// Duration at which the storage engine will snapshot the cache and write it to
    /// a new TSM file if the shard hasn’t received writes or deletes.
    ///
    /// Default: 10 minutes
    storage_cache_snapshot_write_cold_duration: ?Duration = null,

    /// Duration at which the storage engine will compact all TSM files in a shard
    /// if it hasn't received writes or deletes.
    ///
    /// Default: 4 hours
    storage_compact_full_write_cold_duration: ?Duration = null,

    /// Rate limit (in bytes per second) that TSM compactions can write to disk.
    ///
    /// Default: 50331648
    storage_compact_throughput_burst: ?i64 = null,

    /// Maximum number of full and level compactions that can run concurrently. A
    /// value of 0 results in 50% of runtime.GOMAXPROCS(0) used at runtime. Any
    /// number greater than zero limits compactions to that value. This setting does
    /// not apply to cache snapshotting.
    ///
    /// Default: 0
    storage_max_concurrent_compactions: ?i32 = null,

    /// Size (in bytes) at which an index write-ahead log (WAL) file will compact
    /// into an index file. Lower sizes will cause log files to be compacted more
    /// quickly and result in lower heap usage at the expense of write throughput.
    ///
    /// Default: 1048576
    storage_max_index_log_file_size: ?i64 = null,

    /// Skip field size validation on incoming write requests.
    ///
    /// Default: false
    storage_no_validate_field_size: ?bool = null,

    /// Interval of retention policy enforcement checks. Must be greater than 0.
    ///
    /// Default: 30 minutes
    storage_retention_check_interval: ?Duration = null,

    /// Maximum number of snapshot compactions that can run concurrently across all
    /// series partitions in a database.
    ///
    /// Default: 0
    storage_series_file_max_concurrent_snapshot_compactions: ?i32 = null,

    /// Size of the internal cache used in the TSI index to store previously
    /// calculated series results. Cached results are returned quickly rather than
    /// needing to be recalculated when a subsequent query with the same tag
    /// key/value predicate is executed. Setting this value to 0 will disable the
    /// cache and may decrease query performance.
    ///
    /// Default: 100
    storage_series_id_set_cache_size: ?i64 = null,

    /// Maximum number writes to the WAL directory to attempt at the same time.
    /// Setting this value to 0 results in number of processing units available x2.
    ///
    /// Default: 0
    storage_wal_max_concurrent_writes: ?i32 = null,

    /// Maximum amount of time a write request to the WAL directory will wait when
    /// the [maximum number of concurrent active writes to the WAL directory has
    /// been
    /// met](https://docs.influxdata.com/influxdb/v2/reference/config-options/#storage-wal-max-concurrent-writes). Set to 0 to disable the timeout.
    ///
    /// Default: 10 minutes
    storage_wal_max_write_delay: ?Duration = null,

    /// Enable tracing in InfluxDB and specifies the tracing type. Tracing is
    /// disabled by default.
    tracing_type: ?TracingType = null,

    /// Disable the InfluxDB user interface (UI). The UI is enabled by default.
    ///
    /// Default: false
    ui_disabled: ?bool = null,

    pub const json_field_names = .{
        .flux_log_enabled = "fluxLogEnabled",
        .http_idle_timeout = "httpIdleTimeout",
        .http_read_header_timeout = "httpReadHeaderTimeout",
        .http_read_timeout = "httpReadTimeout",
        .http_write_timeout = "httpWriteTimeout",
        .influxql_max_select_buckets = "influxqlMaxSelectBuckets",
        .influxql_max_select_point = "influxqlMaxSelectPoint",
        .influxql_max_select_series = "influxqlMaxSelectSeries",
        .log_level = "logLevel",
        .metrics_disabled = "metricsDisabled",
        .no_tasks = "noTasks",
        .pprof_disabled = "pprofDisabled",
        .query_concurrency = "queryConcurrency",
        .query_initial_memory_bytes = "queryInitialMemoryBytes",
        .query_max_memory_bytes = "queryMaxMemoryBytes",
        .query_memory_bytes = "queryMemoryBytes",
        .query_queue_size = "queryQueueSize",
        .session_length = "sessionLength",
        .session_renew_disabled = "sessionRenewDisabled",
        .storage_cache_max_memory_size = "storageCacheMaxMemorySize",
        .storage_cache_snapshot_memory_size = "storageCacheSnapshotMemorySize",
        .storage_cache_snapshot_write_cold_duration = "storageCacheSnapshotWriteColdDuration",
        .storage_compact_full_write_cold_duration = "storageCompactFullWriteColdDuration",
        .storage_compact_throughput_burst = "storageCompactThroughputBurst",
        .storage_max_concurrent_compactions = "storageMaxConcurrentCompactions",
        .storage_max_index_log_file_size = "storageMaxIndexLogFileSize",
        .storage_no_validate_field_size = "storageNoValidateFieldSize",
        .storage_retention_check_interval = "storageRetentionCheckInterval",
        .storage_series_file_max_concurrent_snapshot_compactions = "storageSeriesFileMaxConcurrentSnapshotCompactions",
        .storage_series_id_set_cache_size = "storageSeriesIdSetCacheSize",
        .storage_wal_max_concurrent_writes = "storageWalMaxConcurrentWrites",
        .storage_wal_max_write_delay = "storageWalMaxWriteDelay",
        .tracing_type = "tracingType",
        .ui_disabled = "uiDisabled",
    };
};
