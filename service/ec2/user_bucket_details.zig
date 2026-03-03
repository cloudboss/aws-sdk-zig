/// Describes the Amazon S3 bucket for the disk image.
pub const UserBucketDetails = struct {
    /// The Amazon S3 bucket from which the disk image was created.
    s3_bucket: ?[]const u8 = null,

    /// The file name of the disk image.
    s3_key: ?[]const u8 = null,
};
