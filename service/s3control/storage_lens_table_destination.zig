const StorageLensDataExportEncryption = @import("storage_lens_data_export_encryption.zig").StorageLensDataExportEncryption;

/// A container for configuring your S3 Storage Lens reports to export to
/// read-only S3 table
/// buckets. This parameter enables you to store your Storage Lens metrics in a
/// structured,
/// queryable table format in Apache Iceberg.
///
/// For more information about S3 Storage Lens, see [Assessing your storage
/// activity and usage with S3 Storage
/// Lens](https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage_lens.html) in the *Amazon S3 User Guide*.
pub const StorageLensTableDestination = struct {
    encryption: ?StorageLensDataExportEncryption = null,

    /// A container that indicates whether the export to read-only S3 table buckets
    /// is enabled
    /// for your S3 Storage Lens configuration. When set to true, Storage Lens
    /// reports are automatically
    /// exported to tables in addition to other configured destinations.
    is_enabled: bool = false,
};
