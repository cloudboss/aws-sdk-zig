/// Describes a disk.
pub const DiskInfo = struct {
    /// A Boolean value indicating whether this disk is a system disk (has an
    /// operating system
    /// loaded on it).
    is_system_disk: ?bool = null,

    /// The disk name.
    name: ?[]const u8 = null,

    /// The disk path.
    path: ?[]const u8 = null,

    /// The size of the disk in GB (`32`).
    size_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .is_system_disk = "isSystemDisk",
        .name = "name",
        .path = "path",
        .size_in_gb = "sizeInGb",
    };
};
