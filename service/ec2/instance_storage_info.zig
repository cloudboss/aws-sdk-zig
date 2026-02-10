const DiskInfo = @import("disk_info.zig").DiskInfo;
const InstanceStorageEncryptionSupport = @import("instance_storage_encryption_support.zig").InstanceStorageEncryptionSupport;
const EphemeralNvmeSupport = @import("ephemeral_nvme_support.zig").EphemeralNvmeSupport;

/// Describes the instance store features that are supported by the instance
/// type.
pub const InstanceStorageInfo = struct {
    /// Describes the disks that are available for the instance type.
    disks: ?[]const DiskInfo,

    /// Indicates whether data is encrypted at rest.
    encryption_support: ?InstanceStorageEncryptionSupport,

    /// Indicates whether non-volatile memory express (NVMe) is supported.
    nvme_support: ?EphemeralNvmeSupport,

    /// The total size of the disks, in GB.
    total_size_in_gb: ?i64,
};
