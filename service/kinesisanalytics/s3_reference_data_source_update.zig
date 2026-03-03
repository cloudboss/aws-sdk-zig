/// Describes the S3 bucket name, object key name, and IAM role that Amazon
/// Kinesis Analytics can assume to read the Amazon S3 object on your behalf and
/// populate the in-application reference table.
pub const S3ReferenceDataSourceUpdate = struct {
    /// Amazon Resource Name (ARN) of the S3 bucket.
    bucket_arn_update: ?[]const u8 = null,

    /// Object key name.
    file_key_update: ?[]const u8 = null,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to read the
    /// Amazon S3 object and populate the in-application.
    reference_role_arn_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_arn_update = "BucketARNUpdate",
        .file_key_update = "FileKeyUpdate",
        .reference_role_arn_update = "ReferenceRoleARNUpdate",
    };
};
