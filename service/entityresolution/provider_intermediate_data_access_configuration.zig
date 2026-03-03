/// The required configuration fields to give intermediate access to a provider
/// service.
pub const ProviderIntermediateDataAccessConfiguration = struct {
    /// The Amazon Web Services account that provider can use to read or write data
    /// into the customer's intermediate S3 bucket.
    aws_account_ids: ?[]const []const u8 = null,

    /// The S3 bucket actions that the provider requires permission for.
    required_bucket_actions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .aws_account_ids = "awsAccountIds",
        .required_bucket_actions = "requiredBucketActions",
    };
};
