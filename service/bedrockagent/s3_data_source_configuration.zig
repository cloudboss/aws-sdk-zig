/// The configuration information to connect to Amazon S3 as your data source.
pub const S3DataSourceConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket that contains your data.
    bucket_arn: []const u8,

    /// The account ID for the owner of the S3 bucket.
    bucket_owner_account_id: ?[]const u8,

    /// A list of S3 prefixes to include certain files or content. For more
    /// information, see [Organizing objects using
    /// prefixes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-prefixes.html).
    inclusion_prefixes: ?[]const []const u8,

    pub const json_field_names = .{
        .bucket_arn = "bucketArn",
        .bucket_owner_account_id = "bucketOwnerAccountId",
        .inclusion_prefixes = "inclusionPrefixes",
    };
};
