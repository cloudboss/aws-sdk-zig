const DiskType = @import("disk_type.zig").DiskType;

/// Describes a disk.
pub const DiskInfo = struct {
    /// The number of disks with this configuration.
    count: ?i32 = null,

    /// The size of the disk in GB.
    size_in_gb: ?i64 = null,

    /// The type of disk.
    @"type": ?DiskType = null,
};
