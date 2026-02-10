const S3Storage = @import("s_3_storage.zig").S3Storage;

/// Describes the storage location for an instance store-backed AMI.
pub const Storage = struct {
    /// An Amazon S3 storage location.
    s_3: ?S3Storage,
};
