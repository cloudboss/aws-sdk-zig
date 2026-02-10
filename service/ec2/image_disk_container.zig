const UserBucket = @import("user_bucket.zig").UserBucket;

/// Describes the disk container object for an import image task.
pub const ImageDiskContainer = struct {
    /// The description of the disk image.
    description: ?[]const u8,

    /// The block device mapping for the disk.
    device_name: ?[]const u8,

    /// The format of the disk image being imported.
    ///
    /// Valid values: `OVA` | `VHD` | `VHDX` | `VMDK` | `RAW`
    format: ?[]const u8,

    /// The ID of the EBS snapshot to be used for importing the snapshot.
    snapshot_id: ?[]const u8,

    /// The URL to the Amazon S3-based disk image being imported. The URL can either
    /// be a https URL (https://..) or an
    /// Amazon S3 URL (s3://..)
    url: ?[]const u8,

    /// The S3 bucket for the disk image.
    user_bucket: ?UserBucket,
};
