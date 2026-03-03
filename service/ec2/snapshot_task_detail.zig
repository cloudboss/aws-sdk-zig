const UserBucketDetails = @import("user_bucket_details.zig").UserBucketDetails;

/// Details about the import snapshot task.
pub const SnapshotTaskDetail = struct {
    /// The description of the disk image being imported.
    description: ?[]const u8 = null,

    /// The size of the disk in the snapshot, in GiB.
    disk_image_size: ?f64 = null,

    /// Indicates whether the snapshot is encrypted.
    encrypted: ?bool = null,

    /// The format of the disk image from which the snapshot is created.
    format: ?[]const u8 = null,

    /// The identifier for the KMS key that was used to create the encrypted
    /// snapshot.
    kms_key_id: ?[]const u8 = null,

    /// The percentage of completion for the import snapshot task.
    progress: ?[]const u8 = null,

    /// The snapshot ID of the disk being imported.
    snapshot_id: ?[]const u8 = null,

    /// A brief status for the import snapshot task.
    status: ?[]const u8 = null,

    /// A detailed status message for the import snapshot task.
    status_message: ?[]const u8 = null,

    /// The URL of the disk image from which the snapshot is created.
    url: ?[]const u8 = null,

    /// The Amazon S3 bucket for the disk image.
    user_bucket: ?UserBucketDetails = null,
};
