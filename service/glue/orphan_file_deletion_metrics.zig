const IcebergOrphanFileDeletionMetrics = @import("iceberg_orphan_file_deletion_metrics.zig").IcebergOrphanFileDeletionMetrics;

/// A structure that contains orphan file deletion metrics for the optimizer
/// run.
pub const OrphanFileDeletionMetrics = struct {
    /// A structure containing the Iceberg orphan file deletion metrics for the
    /// optimizer run.
    iceberg_metrics: ?IcebergOrphanFileDeletionMetrics = null,

    pub const json_field_names = .{
        .iceberg_metrics = "IcebergMetrics",
    };
};
