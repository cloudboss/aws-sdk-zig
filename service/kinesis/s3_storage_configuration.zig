const S3CompressionType = @import("s3_compression_type.zig").S3CompressionType;
const S3StorageClass = @import("s3_storage_class.zig").S3StorageClass;

/// The Amazon S3 storage settings for a general purpose Amazon S3 destination.
pub const S3StorageConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the destination Amazon S3 bucket.
    bucket_arn: []const u8,

    /// The compression applied to delivered objects. Valid values:
    ///
    /// * `NONE` - No compression.
    ///
    /// * `GZIP` - gzip compression.
    ///
    /// * `ZSTD` - Zstandard compression.
    compression_type: S3CompressionType,

    /// The Amazon Web Services account ID of the expected owner of the destination
    /// bucket. This value helps prevent delivery to an unintended bucket if
    /// ownership changes.
    expected_bucket_owner: []const u8,

    /// The template used to construct the Amazon S3 object key for delivered
    /// objects. If not specified, a default template is used.
    output_key_template: ?[]const u8 = null,

    /// The Amazon S3 storage class for delivered objects. Valid values:
    ///
    /// * `STANDARD` - The default storage class, for frequently accessed data.
    ///
    /// * `INTELLIGENT_TIERING` - Automatically moves objects to the most
    ///   cost-effective access tier based on usage patterns.
    ///
    /// * `GLACIER_IR` - Low-cost storage for rarely accessed data that requires
    ///   millisecond retrieval.
    storage_class: ?S3StorageClass = null,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .compression_type = "CompressionType",
        .expected_bucket_owner = "ExpectedBucketOwner",
        .output_key_template = "OutputKeyTemplate",
        .storage_class = "StorageClass",
    };
};
