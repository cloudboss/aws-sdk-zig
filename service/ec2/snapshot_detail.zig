const UserBucketDetails = @import("user_bucket_details.zig").UserBucketDetails;

/// Describes the snapshot created from the imported disk.
pub const SnapshotDetail = struct {
    /// A description for the snapshot.
    description: ?[]const u8,

    /// The block device mapping for the snapshot.
    device_name: ?[]const u8,

    /// The size of the disk in the snapshot, in GiB.
    disk_image_size: ?f64,

    /// The format of the disk image from which the snapshot is created.
    format: ?[]const u8,

    /// The percentage of progress for the task.
    progress: ?[]const u8,

    /// The snapshot ID of the disk being imported.
    snapshot_id: ?[]const u8,

    /// A brief status of the snapshot creation.
    status: ?[]const u8,

    /// A detailed status message for the snapshot creation.
    status_message: ?[]const u8,

    /// The URL used to access the disk image.
    url: ?[]const u8,

    /// The Amazon S3 bucket for the disk image.
    user_bucket: ?UserBucketDetails,
};
