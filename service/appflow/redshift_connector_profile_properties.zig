/// The connector-specific profile properties when using Amazon Redshift.
pub const RedshiftConnectorProfileProperties = struct {
    /// A name for the associated Amazon S3 bucket.
    bucket_name: []const u8,

    /// The object key for the destination bucket in which Amazon AppFlow places the
    /// files.
    bucket_prefix: ?[]const u8,

    /// The unique ID that's assigned to an Amazon Redshift cluster.
    cluster_identifier: ?[]const u8,

    /// The Amazon Resource Name (ARN) of an IAM role that permits Amazon AppFlow to
    /// access your Amazon Redshift database through the Data API. For more
    /// information, and for the polices that you attach to this role, see [Allow
    /// Amazon AppFlow to access Amazon Redshift databases with the Data
    /// API](https://docs.aws.amazon.com/appflow/latest/userguide/security_iam_service-role-policies.html#access-redshift).
    data_api_role_arn: ?[]const u8,

    /// The name of an Amazon Redshift database.
    database_name: ?[]const u8,

    /// The JDBC URL of the Amazon Redshift cluster.
    database_url: ?[]const u8,

    /// Indicates whether the connector profile defines a connection to an Amazon
    /// Redshift
    /// Serverless data warehouse.
    is_redshift_serverless: bool = false,

    /// The Amazon Resource Name (ARN) of IAM role that grants Amazon Redshift
    /// read-only access to Amazon S3. For more information, and for the polices
    /// that you
    /// attach to this role, see [Allow Amazon Redshift to access your Amazon
    /// AppFlow data in Amazon
    /// S3](https://docs.aws.amazon.com/appflow/latest/userguide/security_iam_service-role-policies.html#redshift-access-s3).
    role_arn: []const u8,

    /// The name of an Amazon Redshift workgroup.
    workgroup_name: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .bucket_prefix = "bucketPrefix",
        .cluster_identifier = "clusterIdentifier",
        .data_api_role_arn = "dataApiRoleArn",
        .database_name = "databaseName",
        .database_url = "databaseUrl",
        .is_redshift_serverless = "isRedshiftServerless",
        .role_arn = "roleArn",
        .workgroup_name = "workgroupName",
    };
};
