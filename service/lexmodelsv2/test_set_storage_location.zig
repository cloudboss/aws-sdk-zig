/// Contains information about the location in which the test set is stored.
pub const TestSetStorageLocation = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Web Services Key Management
    /// Service
    /// (KMS) key for encrypting the test set.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the Amazon S3 bucket in which the test set is stored.
    s_3_bucket_name: []const u8,

    /// The path inside the Amazon S3 bucket where the test set is stored.
    s_3_path: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .s_3_bucket_name = "s3BucketName",
        .s_3_path = "s3Path",
    };
};
