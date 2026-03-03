const AwsS3BucketServerSideEncryptionRule = @import("aws_s3_bucket_server_side_encryption_rule.zig").AwsS3BucketServerSideEncryptionRule;

/// The encryption configuration for the S3 bucket.
pub const AwsS3BucketServerSideEncryptionConfiguration = struct {
    /// The encryption rules that are applied to the S3 bucket.
    rules: ?[]const AwsS3BucketServerSideEncryptionRule = null,

    pub const json_field_names = .{
        .rules = "Rules",
    };
};
