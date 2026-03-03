const S3Storage = @import("s3_storage.zig").S3Storage;

/// Describes the storage location for an instance store-backed AMI.
pub const Storage = struct {
    /// An Amazon S3 storage location.
    s3: ?S3Storage = null,
};
