const StorageLensDataExportEncryption = @import("storage_lens_data_export_encryption.zig").StorageLensDataExportEncryption;
const Format = @import("format.zig").Format;
const OutputSchemaVersion = @import("output_schema_version.zig").OutputSchemaVersion;

/// A container for the bucket where the Amazon S3 Storage Lens metrics export
/// files are
/// located.
pub const S3BucketDestination = struct {
    /// The account ID of the owner of the S3 Storage Lens metrics export bucket.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the bucket. This property is read-only and
    /// follows the
    /// following format: `
    /// arn:aws:s3:*us-east-1*:*example-account-id*:bucket/*your-destination-bucket-name*
    /// `
    arn: []const u8,

    /// The container for the type encryption of the metrics exports in this bucket.
    encryption: ?StorageLensDataExportEncryption,

    format: Format,

    /// The schema version of the export file.
    output_schema_version: OutputSchemaVersion,

    /// The prefix of the destination bucket where the metrics export will be
    /// delivered.
    prefix: ?[]const u8,
};
