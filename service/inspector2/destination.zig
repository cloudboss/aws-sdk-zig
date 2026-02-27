/// Contains details of the Amazon S3 bucket and KMS key used to export
/// findings.
pub const Destination = struct {
    /// The name of the Amazon S3 bucket to export findings to.
    bucket_name: []const u8,

    /// The prefix that the findings will be written under.
    key_prefix: ?[]const u8,

    /// The ARN of the KMS key used to encrypt data when exporting findings.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .key_prefix = "keyPrefix",
        .kms_key_arn = "kmsKeyArn",
    };
};
