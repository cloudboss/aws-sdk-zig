/// For a SQL-based Kinesis Data Analytics application, provides the bucket name
/// and
/// object key name that stores the reference data.
pub const S3ReferenceDataSourceDescription = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket.
    bucket_arn: []const u8,

    /// Amazon S3 object key name.
    file_key: []const u8,

    /// The ARN of the IAM role that Kinesis Data Analytics can assume to read the
    /// Amazon S3
    /// object on your behalf to populate the in-application reference table.
    ///
    /// Provided for backward compatibility. Applications that are created with the
    /// current API
    /// version have an application-level service execution role rather than a
    /// resource-level
    /// role.
    reference_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .file_key = "FileKey",
        .reference_role_arn = "ReferenceRoleARN",
    };
};
