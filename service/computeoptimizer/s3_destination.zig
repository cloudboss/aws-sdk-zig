/// Describes the destination Amazon Simple Storage Service (Amazon S3) bucket
/// name and
/// object keys of a recommendations export file, and its associated metadata
/// file.
pub const S3Destination = struct {
    /// The name of the Amazon S3 bucket used as the destination of an export
    /// file.
    bucket: ?[]const u8 = null,

    /// The Amazon S3 bucket key of an export file.
    ///
    /// The key uniquely identifies the object, or export file, in the S3 bucket.
    key: ?[]const u8 = null,

    /// The Amazon S3 bucket key of a metadata file.
    ///
    /// The key uniquely identifies the object, or metadata file, in the S3 bucket.
    metadata_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
        .metadata_key = "metadataKey",
    };
};
