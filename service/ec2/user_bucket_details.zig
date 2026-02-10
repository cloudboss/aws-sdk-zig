/// Describes the Amazon S3 bucket for the disk image.
pub const UserBucketDetails = struct {
    /// The Amazon S3 bucket from which the disk image was created.
    s_3_bucket: ?[]const u8,

    /// The file name of the disk image.
    s_3_key: ?[]const u8,
};
