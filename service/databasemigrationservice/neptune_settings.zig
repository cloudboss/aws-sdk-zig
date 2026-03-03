/// Provides information that defines an Amazon Neptune endpoint.
pub const NeptuneSettings = struct {
    /// The number of milliseconds for DMS to wait to retry a bulk-load of migrated
    /// graph data
    /// to the Neptune target database before raising an error. The default is 250.
    error_retry_duration: ?i32 = null,

    /// If you want Identity and Access Management (IAM) authorization enabled for
    /// this endpoint, set this parameter
    /// to `true`. Then attach the appropriate IAM policy document to your service
    /// role
    /// specified by `ServiceAccessRoleArn`. The default is `false`.
    iam_auth_enabled: ?bool = null,

    /// The maximum size in kilobytes of migrated graph data stored in a .csv file
    /// before DMS
    /// bulk-loads the data to the Neptune target database. The default is 1,048,576
    /// KB. If the
    /// bulk load is successful, DMS clears the bucket, ready to store the next
    /// batch of migrated
    /// graph data.
    max_file_size: ?i32 = null,

    /// The number of times for DMS to retry a bulk load of migrated graph data to
    /// the Neptune
    /// target database before raising an error. The default is 5.
    max_retry_count: ?i32 = null,

    /// A folder path where you want DMS to store migrated graph data in the S3
    /// bucket
    /// specified by `S3BucketName`
    s3_bucket_folder: []const u8,

    /// The name of the Amazon S3 bucket where DMS can temporarily store migrated
    /// graph data
    /// in .csv files before bulk-loading it to the Neptune target database. DMS
    /// maps the SQL
    /// source data to graph data before storing it in these .csv files.
    s3_bucket_name: []const u8,

    /// The Amazon Resource Name (ARN) of the service role that you created for the
    /// Neptune
    /// target endpoint. The role must allow the `iam:PassRole` action. For more
    /// information, see [Creating an IAM Service Role for Accessing Amazon Neptune
    /// as a
    /// Target](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Neptune.html#CHAP_Target.Neptune.ServiceRole) in the *Database Migration Service User Guide. *
    service_access_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_retry_duration = "ErrorRetryDuration",
        .iam_auth_enabled = "IamAuthEnabled",
        .max_file_size = "MaxFileSize",
        .max_retry_count = "MaxRetryCount",
        .s3_bucket_folder = "S3BucketFolder",
        .s3_bucket_name = "S3BucketName",
        .service_access_role_arn = "ServiceAccessRoleArn",
    };
};
