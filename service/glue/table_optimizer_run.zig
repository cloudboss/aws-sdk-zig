const CompactionMetrics = @import("compaction_metrics.zig").CompactionMetrics;
const CompactionStrategy = @import("compaction_strategy.zig").CompactionStrategy;
const TableOptimizerEventType = @import("table_optimizer_event_type.zig").TableOptimizerEventType;
const RunMetrics = @import("run_metrics.zig").RunMetrics;
const OrphanFileDeletionMetrics = @import("orphan_file_deletion_metrics.zig").OrphanFileDeletionMetrics;
const RetentionMetrics = @import("retention_metrics.zig").RetentionMetrics;

/// Contains details for a table optimizer run.
pub const TableOptimizerRun = struct {
    /// A `CompactionMetrics` object containing metrics for the optimizer run.
    compaction_metrics: ?CompactionMetrics,

    /// The strategy used for the compaction run. Indicates which algorithm was
    /// applied to determine how files were selected and combined during the
    /// compaction process. Valid values are:
    ///
    /// * `binpack`: Combines small files into larger files, typically targeting
    ///   sizes over 100MB, while applying any pending deletes.
    /// This is the recommended compaction strategy for most use cases.
    ///
    /// * `sort`: Organizes data based on specified columns which are sorted
    ///   hierarchically during compaction, improving query
    /// performance for filtered operations. This strategy is recommended when your
    /// queries frequently filter on specific columns. To use this strategy,
    /// you must first define a sort order in your Iceberg table properties using
    /// the `sort_order` table property.
    ///
    /// * `z-order`: Optimizes data organization by blending multiple attributes
    ///   into a single scalar value that can be used for sorting,
    /// allowing efficient querying across multiple dimensions. This strategy is
    /// recommended when you need to query data across multiple dimensions
    /// simultaneously. To use this strategy, you must first define a sort order in
    /// your Iceberg table properties using the
    /// `sort_order` table property.
    compaction_strategy: ?CompactionStrategy,

    /// Represents the epoch timestamp at which the compaction job ended.
    end_timestamp: ?i64,

    /// An error that occured during the optimizer run.
    @"error": ?[]const u8,

    /// An event type representing the status of the table optimizer run.
    event_type: ?TableOptimizerEventType,

    /// A `RunMetrics` object containing metrics for the optimizer run.
    ///
    /// This member is deprecated. See the individual metric members for compaction,
    /// retention, and orphan file deletion.
    metrics: ?RunMetrics,

    /// An `OrphanFileDeletionMetrics` object containing metrics for the optimizer
    /// run.
    orphan_file_deletion_metrics: ?OrphanFileDeletionMetrics,

    /// A `RetentionMetrics` object containing metrics for the optimizer run.
    retention_metrics: ?RetentionMetrics,

    /// Represents the epoch timestamp at which the compaction job was started
    /// within Lake Formation.
    start_timestamp: ?i64,

    pub const json_field_names = .{
        .compaction_metrics = "compactionMetrics",
        .compaction_strategy = "compactionStrategy",
        .end_timestamp = "endTimestamp",
        .@"error" = "error",
        .event_type = "eventType",
        .metrics = "metrics",
        .orphan_file_deletion_metrics = "orphanFileDeletionMetrics",
        .retention_metrics = "retentionMetrics",
        .start_timestamp = "startTimestamp",
    };
};
