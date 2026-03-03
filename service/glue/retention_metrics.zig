const IcebergRetentionMetrics = @import("iceberg_retention_metrics.zig").IcebergRetentionMetrics;

/// A structure that contains retention metrics for the optimizer run.
pub const RetentionMetrics = struct {
    /// A structure containing the Iceberg retention metrics for the optimizer run.
    iceberg_metrics: ?IcebergRetentionMetrics = null,

    pub const json_field_names = .{
        .iceberg_metrics = "IcebergMetrics",
    };
};
