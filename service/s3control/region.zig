/// A Region that supports a Multi-Region Access Point as well as the associated
/// bucket for the Region.
pub const Region = struct {
    /// The name of the associated bucket for the Region.
    bucket: []const u8,

    /// The Amazon Web Services account ID that owns the Amazon S3 bucket that's
    /// associated with this
    /// Multi-Region Access Point.
    bucket_account_id: ?[]const u8,
};
