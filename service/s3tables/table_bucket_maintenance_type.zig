pub const TableBucketMaintenanceType = enum {
    iceberg_unreferenced_file_removal,

    pub const json_field_names = .{
        .iceberg_unreferenced_file_removal = "ICEBERG_UNREFERENCED_FILE_REMOVAL",
    };
};
