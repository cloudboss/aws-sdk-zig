const IcebergCompactionMetrics = @import("iceberg_compaction_metrics.zig").IcebergCompactionMetrics;

/// A structure that contains compaction metrics for the optimizer run.
pub const CompactionMetrics = struct {
    /// A structure containing the Iceberg compaction metrics for the optimizer run.
    iceberg_metrics: ?IcebergCompactionMetrics = null,

    pub const json_field_names = .{
        .iceberg_metrics = "IcebergMetrics",
    };
};
