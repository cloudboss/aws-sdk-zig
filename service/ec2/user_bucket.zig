/// Describes the Amazon S3 bucket for the disk image.
pub const UserBucket = struct {
    /// The name of the Amazon S3 bucket where the disk image is located.
    s3_bucket: ?[]const u8 = null,

    /// The file name of the disk image.
    s3_key: ?[]const u8 = null,
};
