const IcebergCompactionSettings = @import("iceberg_compaction_settings.zig").IcebergCompactionSettings;
const IcebergSnapshotManagementSettings = @import("iceberg_snapshot_management_settings.zig").IcebergSnapshotManagementSettings;

/// Contains details about maintenance settings for the table.
pub const TableMaintenanceSettings = union(enum) {
    /// Contains details about the Iceberg compaction settings for the table.
    iceberg_compaction: ?IcebergCompactionSettings,
    /// Contains details about the Iceberg snapshot management settings for the
    /// table.
    iceberg_snapshot_management: ?IcebergSnapshotManagementSettings,

    pub const json_field_names = .{
        .iceberg_compaction = "icebergCompaction",
        .iceberg_snapshot_management = "icebergSnapshotManagement",
    };
};
