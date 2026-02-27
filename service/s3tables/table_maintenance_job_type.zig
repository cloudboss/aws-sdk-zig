pub const TableMaintenanceJobType = enum {
    iceberg_compaction,
    iceberg_snapshot_management,
    iceberg_unreferenced_file_removal,

    pub const json_field_names = .{
        .iceberg_compaction = "ICEBERG_COMPACTION",
        .iceberg_snapshot_management = "ICEBERG_SNAPSHOT_MANAGEMENT",
        .iceberg_unreferenced_file_removal = "ICEBERG_UNREFERENCED_FILE_REMOVAL",
    };
};
