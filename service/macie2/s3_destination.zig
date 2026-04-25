/// Specifies an S3 bucket to store data classification results in, and the
/// encryption settings to use when storing results in that bucket. The bucket
/// must be an existing general purpose bucket. It can be a bucket in your own
/// account or a bucket that another account owns. If another account owns the
/// bucket, you must specify both the unique identifier for the account and the
/// name of the bucket.
pub const S3Destination = struct {
    /// The name of the bucket. This must be the name of an existing general purpose
    /// bucket.
    bucket_name: []const u8,

    /// The unique identifier (ID) for the Amazon Web Services account that owns the
    /// bucket. This must be the ID for the account that owns the specified bucket.
    expected_bucket_owner: ?[]const u8 = null,

    /// The path prefix to use in the path to the location in the bucket. This
    /// prefix specifies where to store classification results in the bucket.
    key_prefix: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the customer managed KMS key to use for
    /// encryption of the results. This must be the ARN of an existing, symmetric
    /// encryption KMS key that's enabled in the same Amazon Web Services Region as
    /// the bucket.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .expected_bucket_owner = "expectedBucketOwner",
        .key_prefix = "keyPrefix",
        .kms_key_arn = "kmsKeyArn",
    };
};
