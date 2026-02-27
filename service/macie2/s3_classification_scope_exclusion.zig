/// Specifies the names of the S3 buckets that are excluded from automated
/// sensitive data discovery.
pub const S3ClassificationScopeExclusion = struct {
    /// An array of strings, one for each S3 bucket that is excluded. Each string is
    /// the full name of an excluded bucket.
    bucket_names: []const []const u8,

    pub const json_field_names = .{
        .bucket_names = "bucketNames",
    };
};
