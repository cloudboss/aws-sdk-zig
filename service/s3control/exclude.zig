/// A container for what Amazon S3 Storage Lens will exclude.
pub const Exclude = struct {
    /// A container for the S3 Storage Lens bucket excludes.
    buckets: ?[]const []const u8 = null,

    /// A container for the S3 Storage Lens Region excludes.
    regions: ?[]const []const u8 = null,
};
