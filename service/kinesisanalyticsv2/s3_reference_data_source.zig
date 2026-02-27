/// For a SQL-based Kinesis Data Analytics application, identifies the Amazon S3
/// bucket and object that contains the reference data.
///
/// A SQL-based Kinesis Data Analytics application loads reference data only
/// once. If the data changes, you call the UpdateApplication
/// operation to trigger reloading of data into your application.
pub const S3ReferenceDataSource = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket.
    bucket_arn: ?[]const u8,

    /// The object key name containing the reference data.
    file_key: ?[]const u8,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .file_key = "FileKey",
    };
};
