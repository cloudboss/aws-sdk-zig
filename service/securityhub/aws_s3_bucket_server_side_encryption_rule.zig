const AwsS3BucketServerSideEncryptionByDefault = @import("aws_s3_bucket_server_side_encryption_by_default.zig").AwsS3BucketServerSideEncryptionByDefault;

/// An encryption rule to apply to the S3 bucket.
pub const AwsS3BucketServerSideEncryptionRule = struct {
    /// Specifies the default server-side encryption to apply to new objects in the
    /// bucket. If a
    /// `PUT` object request doesn't specify any server-side encryption, this
    /// default
    /// encryption is applied.
    apply_server_side_encryption_by_default: ?AwsS3BucketServerSideEncryptionByDefault,

    pub const json_field_names = .{
        .apply_server_side_encryption_by_default = "ApplyServerSideEncryptionByDefault",
    };
};
