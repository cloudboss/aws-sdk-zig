const S3CompressionType = @import("s3_compression_type.zig").S3CompressionType;
const S3StorageClass = @import("s3_storage_class.zig").S3StorageClass;

/// Storage configuration for an Amazon S3 destination bucket.
pub const S3Storage = struct {
    /// The Amazon Resource Name (ARN) of the destination Amazon S3 bucket.
    bucket_arn: []const u8,

    /// The compression codec applied to delivered Amazon S3 objects.
    compression_type: S3CompressionType,

    /// Optional 12-digit AWS account ID expected to own the Amazon S3 bucket.
    expected_bucket_owner: ?[]const u8 = null,

    /// An optional template that controls the Amazon S3 object key for each
    /// delivered record. Supports the placeholders !{partition-id},
    /// !{sequence-number}, and !{kafka-offset}.
    output_key_template: ?[]const u8 = null,

    /// An optional prefix prepended to every Amazon S3 object key written by the
    /// channel.
    output_prefix: ?[]const u8 = null,

    /// The Amazon S3 storage class for delivered objects.
    storage_class: S3StorageClass,

    pub const json_field_names = .{
        .bucket_arn = "BucketArn",
        .compression_type = "CompressionType",
        .expected_bucket_owner = "ExpectedBucketOwner",
        .output_key_template = "OutputKeyTemplate",
        .output_prefix = "OutputPrefix",
        .storage_class = "StorageClass",
    };
};
