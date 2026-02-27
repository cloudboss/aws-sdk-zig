/// The configuration used for the Glue Crawler for a third-party custom source.
pub const CustomLogSourceCrawlerConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role
    /// to be used by the Glue crawler. The recommended IAM policies
    /// are:
    ///
    /// * The managed policy `AWSGlueServiceRole`
    ///
    /// * A custom policy granting access to your Amazon S3 Data Lake
    role_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "roleArn",
    };
};
