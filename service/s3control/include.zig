/// A container for what Amazon S3 Storage Lens configuration includes.
pub const Include = struct {
    /// A container for the S3 Storage Lens bucket includes.
    buckets: ?[]const []const u8 = null,

    /// A container for the S3 Storage Lens Region includes.
    regions: ?[]const []const u8 = null,
};
