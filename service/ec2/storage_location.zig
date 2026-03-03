/// Describes a storage location in Amazon S3.
pub const StorageLocation = struct {
    /// The name of the S3 bucket.
    bucket: ?[]const u8 = null,

    /// The key.
    key: ?[]const u8 = null,
};
