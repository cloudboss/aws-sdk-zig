/// For a SQL-based Kinesis Data Analytics application, provides a description
/// of an
/// Amazon S3 data source, including the Amazon Resource Name (ARN) of the S3
/// bucket and the name
/// of the Amazon S3 object that contains the data.
pub const S3Configuration = struct {
    /// The ARN of the S3 bucket that contains the data.
    bucket_arn: []const u8,

    /// The name of the object that contains the data.
    file_key: []const u8,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .file_key = "FileKey",
    };
};
