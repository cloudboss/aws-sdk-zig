const Duration = @import("duration.zig").Duration;
const DataFusionRuntimeType = @import("data_fusion_runtime_type.zig").DataFusionRuntimeType;
const PercentOrAbsoluteLong = @import("percent_or_absolute_long.zig").PercentOrAbsoluteLong;
const LogFormats = @import("log_formats.zig").LogFormats;

/// All the customer-modifiable InfluxDB v3 Core parameters in Timestream for
/// InfluxDB.
pub const InfluxDBv3CoreParameters = struct {
    /// Provides custom configuration to DataFusion as a comma-separated list of
    /// key:value pairs.
    data_fusion_config: ?[]const u8 = null,

    /// When multiple parquet files are required in a sorted way (deduplication for
    /// example), specifies the maximum fanout.
    ///
    /// Default: 1000
    data_fusion_max_parquet_fanout: ?i32 = null,

    /// Sets the maximum number of DataFusion runtime threads to use.
    data_fusion_num_threads: ?i32 = null,

    /// Disables the LIFO slot of the DataFusion runtime.
    data_fusion_runtime_disable_lifo_slot: ?bool = null,

    /// Sets the number of scheduler ticks after which the scheduler of the
    /// DataFusion tokio runtime polls for external events–for example: timers, I/O.
    data_fusion_runtime_event_interval: ?i32 = null,

    /// Sets the number of scheduler ticks after which the scheduler of the
    /// DataFusion runtime polls the global task queue.
    data_fusion_runtime_global_queue_interval: ?i32 = null,

    /// Specifies the limit for additional threads spawned by the DataFusion
    /// runtime.
    data_fusion_runtime_max_blocking_threads: ?i32 = null,

    /// Configures the maximum number of events processed per tick by the tokio
    /// DataFusion runtime.
    data_fusion_runtime_max_io_events_per_tick: ?i32 = null,

    /// Sets a custom timeout for a thread in the blocking pool of the tokio
    /// DataFusion runtime.
    data_fusion_runtime_thread_keep_alive: ?Duration = null,

    /// Sets the thread priority for tokio DataFusion runtime workers.
    ///
    /// Default: 10
    data_fusion_runtime_thread_priority: ?i32 = null,

    /// Specifies the DataFusion tokio runtime type.
    ///
    /// Default: multi-thread
    data_fusion_runtime_type: ?DataFusionRuntimeType = null,

    /// Uses a cached parquet loader when reading parquet files from the object
    /// store.
    data_fusion_use_cached_parquet_loader: ?bool = null,

    /// Specifies the grace period before permanently deleting data.
    ///
    /// Default: 24h
    delete_grace_period: ?Duration = null,

    /// Disables the in-memory Parquet cache. By default, the cache is enabled.
    disable_parquet_mem_cache: ?bool = null,

    /// Specifies the interval to evict expired entries from the distinct value
    /// cache, expressed as a human-readable duration–for example: 20s, 1m, 1h.
    ///
    /// Default: 10s
    distinct_cache_eviction_interval: ?Duration = null,

    /// Specifies the size of memory pool used during query execution. Can be given
    /// as absolute value in bytes or as a percentage of the total available
    /// memory–for example: 8000000000 or 10%.
    ///
    /// Default: 20%
    exec_mem_pool_bytes: ?PercentOrAbsoluteLong = null,

    /// Specifies the threshold for the internal memory buffer. Supports either a
    /// percentage (portion of available memory) or absolute value in MB–for
    /// example: 70% or 100
    ///
    /// Default: 70%
    force_snapshot_mem_threshold: ?PercentOrAbsoluteLong = null,

    /// Specifies the duration that Parquet files are arranged into. Data timestamps
    /// land each row into a file of this duration. Supported durations are 1m, 5m,
    /// and 10m. These files are known as “generation 1” files that the compactor in
    /// InfluxDB 3 Enterprise can merge into larger generations.
    ///
    /// Default: 10m
    gen_1_duration: ?Duration = null,

    /// Specifies how far back to look when creating generation 1 Parquet files.
    ///
    /// Default: 24h
    gen_1_lookback_duration: ?Duration = null,

    /// Sets the default duration for hard deletion of data.
    ///
    /// Default: 90d
    hard_delete_default_duration: ?Duration = null,

    /// Specifies the interval to evict expired entries from the Last-N-Value cache,
    /// expressed as a human-readable duration–for example: 20s, 1m, 1h.
    ///
    /// Default: 10s
    last_cache_eviction_interval: ?Duration = null,

    /// Sets the filter directive for logs.
    log_filter: ?[]const u8 = null,

    /// Defines the message format for logs.
    ///
    /// Default: full
    log_format: ?LogFormats = null,

    /// Specifies the maximum size of HTTP requests.
    ///
    /// Default: 10485760
    max_http_request_size: ?i64 = null,

    /// Sets the interval to check if the in-memory Parquet cache needs to be
    /// pruned.
    ///
    /// Default: 1s
    parquet_mem_cache_prune_interval: ?Duration = null,

    /// Specifies the percentage of entries to prune during a prune operation on the
    /// in-memory Parquet cache.
    ///
    /// Default: 0.1
    parquet_mem_cache_prune_percentage: ?f32 = null,

    /// Specifies the time window for caching recent Parquet files in memory.
    ///
    /// Default: 5h
    parquet_mem_cache_query_path_duration: ?Duration = null,

    /// Specifies the size of the in-memory Parquet cache in megabytes or percentage
    /// of total available memory.
    ///
    /// Default: 20%
    parquet_mem_cache_size: ?PercentOrAbsoluteLong = null,

    /// Specifies the interval to prefetch into the Parquet cache during compaction.
    ///
    /// Default: 3d
    preemptive_cache_age: ?Duration = null,

    /// Limits the number of Parquet files a query can access. If a query attempts
    /// to read more than this limit, InfluxDB 3 returns an error.
    ///
    /// Default: 432
    query_file_limit: ?i32 = null,

    /// Defines the size of the query log. Up to this many queries remain in the log
    /// before older queries are evicted to make room for new ones.
    ///
    /// Default: 1000
    query_log_size: ?i32 = null,

    /// The interval at which retention policies are checked and enforced. Enter as
    /// a human-readable time–for example: 30m or 1h.
    ///
    /// Default: 30m
    retention_check_interval: ?Duration = null,

    /// Specifies the number of snapshotted WAL files to retain in the object store.
    /// Flushing the WAL files does not clear the WAL files immediately; they are
    /// deleted when the number of snapshotted WAL files exceeds this number.
    ///
    /// Default: 300
    snapshotted_wal_files_to_keep: ?i32 = null,

    /// Limits the concurrency level for table index cache operations.
    ///
    /// Default: 8
    table_index_cache_concurrency_limit: ?i32 = null,

    /// Specifies the maximum number of entries in the table index cache.
    ///
    /// Default: 1000
    table_index_cache_max_entries: ?i32 = null,

    /// Specifies the maximum number of write requests that can be buffered before a
    /// flush must be executed and succeed.
    ///
    /// Default: 100000
    wal_max_write_buffer_size: ?i32 = null,

    /// Concurrency limit during WAL replay. Setting this number too high can lead
    /// to OOM. The default is dynamically determined.
    ///
    /// Default: max(num_cpus, 10)
    wal_replay_concurrency_limit: ?i32 = null,

    /// Determines whether WAL replay should fail when encountering errors.
    ///
    /// Default: false
    wal_replay_fail_on_error: ?bool = null,

    /// Defines the number of WAL files to attempt to remove in a snapshot. This,
    /// multiplied by the interval, determines how often snapshots are taken.
    ///
    /// Default: 600
    wal_snapshot_size: ?i32 = null,

    pub const json_field_names = .{
        .data_fusion_config = "dataFusionConfig",
        .data_fusion_max_parquet_fanout = "dataFusionMaxParquetFanout",
        .data_fusion_num_threads = "dataFusionNumThreads",
        .data_fusion_runtime_disable_lifo_slot = "dataFusionRuntimeDisableLifoSlot",
        .data_fusion_runtime_event_interval = "dataFusionRuntimeEventInterval",
        .data_fusion_runtime_global_queue_interval = "dataFusionRuntimeGlobalQueueInterval",
        .data_fusion_runtime_max_blocking_threads = "dataFusionRuntimeMaxBlockingThreads",
        .data_fusion_runtime_max_io_events_per_tick = "dataFusionRuntimeMaxIoEventsPerTick",
        .data_fusion_runtime_thread_keep_alive = "dataFusionRuntimeThreadKeepAlive",
        .data_fusion_runtime_thread_priority = "dataFusionRuntimeThreadPriority",
        .data_fusion_runtime_type = "dataFusionRuntimeType",
        .data_fusion_use_cached_parquet_loader = "dataFusionUseCachedParquetLoader",
        .delete_grace_period = "deleteGracePeriod",
        .disable_parquet_mem_cache = "disableParquetMemCache",
        .distinct_cache_eviction_interval = "distinctCacheEvictionInterval",
        .exec_mem_pool_bytes = "execMemPoolBytes",
        .force_snapshot_mem_threshold = "forceSnapshotMemThreshold",
        .gen_1_duration = "gen1Duration",
        .gen_1_lookback_duration = "gen1LookbackDuration",
        .hard_delete_default_duration = "hardDeleteDefaultDuration",
        .last_cache_eviction_interval = "lastCacheEvictionInterval",
        .log_filter = "logFilter",
        .log_format = "logFormat",
        .max_http_request_size = "maxHttpRequestSize",
        .parquet_mem_cache_prune_interval = "parquetMemCachePruneInterval",
        .parquet_mem_cache_prune_percentage = "parquetMemCachePrunePercentage",
        .parquet_mem_cache_query_path_duration = "parquetMemCacheQueryPathDuration",
        .parquet_mem_cache_size = "parquetMemCacheSize",
        .preemptive_cache_age = "preemptiveCacheAge",
        .query_file_limit = "queryFileLimit",
        .query_log_size = "queryLogSize",
        .retention_check_interval = "retentionCheckInterval",
        .snapshotted_wal_files_to_keep = "snapshottedWalFilesToKeep",
        .table_index_cache_concurrency_limit = "tableIndexCacheConcurrencyLimit",
        .table_index_cache_max_entries = "tableIndexCacheMaxEntries",
        .wal_max_write_buffer_size = "walMaxWriteBufferSize",
        .wal_replay_concurrency_limit = "walReplayConcurrencyLimit",
        .wal_replay_fail_on_error = "walReplayFailOnError",
        .wal_snapshot_size = "walSnapshotSize",
    };
};
