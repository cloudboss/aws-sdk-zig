const IcebergCompactionConfiguration = @import("iceberg_compaction_configuration.zig").IcebergCompactionConfiguration;

/// The configuration for a compaction optimizer. This configuration defines how
/// data files in your table will be compacted to improve
/// query performance and reduce storage costs.
pub const CompactionConfiguration = struct {
    /// The configuration for an Iceberg compaction optimizer.
    iceberg_configuration: ?IcebergCompactionConfiguration = null,

    pub const json_field_names = .{
        .iceberg_configuration = "icebergConfiguration",
    };
};
