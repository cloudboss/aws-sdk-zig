/// Provides the bucket name and object key name that stores the reference data.
pub const S3ReferenceDataSourceDescription = struct {
    /// Amazon Resource Name (ARN) of the S3 bucket.
    bucket_arn: []const u8,

    /// Amazon S3 object key name.
    file_key: []const u8,

    /// ARN of the IAM role that Amazon Kinesis Analytics can assume to read the
    /// Amazon S3 object on your behalf to populate the in-application reference
    /// table.
    reference_role_arn: []const u8,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .file_key = "FileKey",
        .reference_role_arn = "ReferenceRoleARN",
    };
};
