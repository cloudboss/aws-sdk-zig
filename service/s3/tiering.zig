const IntelligentTieringAccessTier = @import("intelligent_tiering_access_tier.zig").IntelligentTieringAccessTier;

/// The S3 Intelligent-Tiering storage class is designed to optimize storage
/// costs by automatically
/// moving data to the most cost-effective storage access tier, without
/// additional operational
/// overhead.
pub const Tiering = struct {
    /// S3 Intelligent-Tiering access tier. See [Storage class for
    /// automatically optimizing frequently and infrequently accessed
    /// objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html#sc-dynamic-data-access) for a list of access
    /// tiers in the S3 Intelligent-Tiering storage class.
    access_tier: IntelligentTieringAccessTier,

    /// The number of consecutive days of no access after which an object will be
    /// eligible to be
    /// transitioned to the corresponding tier. The minimum number of days specified
    /// for Archive Access tier
    /// must be at least 90 days and Deep Archive Access tier must be at least 180
    /// days. The maximum can be up to
    /// 2 years (730 days).
    days: i32,
};
