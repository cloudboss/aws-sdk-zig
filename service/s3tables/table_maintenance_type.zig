pub const TableMaintenanceType = enum {
    iceberg_compaction,
    iceberg_snapshot_management,

    pub const json_field_names = .{
        .iceberg_compaction = "ICEBERG_COMPACTION",
        .iceberg_snapshot_management = "ICEBERG_SNAPSHOT_MANAGEMENT",
    };
};
