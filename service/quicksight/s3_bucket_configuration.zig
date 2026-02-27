/// An optional structure that contains the Amazon S3 bucket configuration that
/// the generated snapshots are stored in. If you don't provide this
/// information, generated snapshots are stored in the default Amazon Quick
/// Sight bucket.
pub const S3BucketConfiguration = struct {
    /// The name of an existing Amazon S3 bucket where the generated snapshot
    /// artifacts are sent.
    bucket_name: []const u8,

    /// The prefix of the Amazon S3 bucket that the generated snapshots are stored
    /// in.
    bucket_prefix: []const u8,

    /// The region that the Amazon S3 bucket is located in. The bucket must be
    /// located in the same region that the `StartDashboardSnapshotJob` API call is
    /// made.
    bucket_region: []const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .bucket_prefix = "BucketPrefix",
        .bucket_region = "BucketRegion",
    };
};
