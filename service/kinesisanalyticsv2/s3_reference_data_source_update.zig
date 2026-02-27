/// For a SQL-based Kinesis Data Analytics application, describes the Amazon S3
/// bucket
/// name and object key name for an in-application reference table.
pub const S3ReferenceDataSourceUpdate = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket.
    bucket_arn_update: ?[]const u8,

    /// The object key name.
    file_key_update: ?[]const u8,

    pub const json_field_names = .{
        .bucket_arn_update = "BucketARNUpdate",
        .file_key_update = "FileKeyUpdate",
    };
};
