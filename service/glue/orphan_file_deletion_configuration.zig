const IcebergOrphanFileDeletionConfiguration = @import("iceberg_orphan_file_deletion_configuration.zig").IcebergOrphanFileDeletionConfiguration;

/// The configuration for an orphan file deletion optimizer.
pub const OrphanFileDeletionConfiguration = struct {
    /// The configuration for an Iceberg orphan file deletion optimizer.
    iceberg_configuration: ?IcebergOrphanFileDeletionConfiguration = null,

    pub const json_field_names = .{
        .iceberg_configuration = "icebergConfiguration",
    };
};
