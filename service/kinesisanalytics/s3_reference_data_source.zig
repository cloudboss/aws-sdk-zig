/// Identifies the S3 bucket and object that contains the reference data. Also
/// identifies the IAM role Amazon Kinesis Analytics can assume to read this
/// object on your behalf.
///
/// An Amazon Kinesis Analytics application loads reference data only once. If
/// the data changes,
/// you call the
/// [UpdateApplication](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_UpdateApplication.html) operation to trigger
/// reloading of data into your application.
pub const S3ReferenceDataSource = struct {
    /// Amazon Resource Name (ARN) of the S3 bucket.
    bucket_arn: []const u8,

    /// Object key name containing reference data.
    file_key: []const u8,

    /// ARN of the IAM role that the service can assume to read data on your behalf.
    /// This role must have permission for the `s3:GetObject` action on the object
    /// and trust policy that allows Amazon Kinesis Analytics service principal to
    /// assume this role.
    reference_role_arn: []const u8,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .file_key = "FileKey",
        .reference_role_arn = "ReferenceRoleARN",
    };
};
