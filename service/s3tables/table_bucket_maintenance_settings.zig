const IcebergUnreferencedFileRemovalSettings = @import("iceberg_unreferenced_file_removal_settings.zig").IcebergUnreferencedFileRemovalSettings;

/// Contains details about the maintenance settings for the table bucket.
pub const TableBucketMaintenanceSettings = union(enum) {
    /// The unreferenced file removal settings for the table bucket.
    iceberg_unreferenced_file_removal: ?IcebergUnreferencedFileRemovalSettings,

    pub const json_field_names = .{
        .iceberg_unreferenced_file_removal = "icebergUnreferencedFileRemoval",
    };
};
