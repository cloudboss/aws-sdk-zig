/// A combination of a bucket and Region that's part of a Multi-Region Access
/// Point.
pub const RegionReport = struct {
    /// The name of the bucket.
    bucket: ?[]const u8 = null,

    /// The Amazon Web Services account ID that owns the Amazon S3 bucket that's
    /// associated with this
    /// Multi-Region Access Point.
    bucket_account_id: ?[]const u8 = null,

    /// The name of the Region.
    region: ?[]const u8 = null,
};
