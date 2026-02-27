/// Specifies an Amazon Web Services account that owns S3 buckets for a
/// classification job to analyze, and one or more specific buckets to analyze
/// for that account.
pub const S3BucketDefinitionForJob = struct {
    /// The unique identifier for the Amazon Web Services account that owns the
    /// buckets.
    account_id: []const u8,

    /// An array that lists the names of the buckets.
    buckets: []const []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .buckets = "buckets",
    };
};
