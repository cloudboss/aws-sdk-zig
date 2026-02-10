const UserBucket = @import("user_bucket.zig").UserBucket;

/// The disk container object for the import snapshot request.
pub const SnapshotDiskContainer = struct {
    /// The description of the disk image being imported.
    description: ?[]const u8,

    /// The format of the disk image being imported.
    ///
    /// Valid values: `VHD` | `VMDK` | `RAW`
    format: ?[]const u8,

    /// The URL to the Amazon S3-based disk image being imported. It can either be a
    /// https URL (https://..) or an Amazon
    /// S3 URL (s3://..).
    url: ?[]const u8,

    /// The Amazon S3 bucket for the disk image.
    user_bucket: ?UserBucket,
};
