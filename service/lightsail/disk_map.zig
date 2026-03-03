/// Describes a block storage disk mapping.
pub const DiskMap = struct {
    /// The new disk name (`my-new-disk`).
    new_disk_name: ?[]const u8 = null,

    /// The original disk path exposed to the instance (for example,
    /// `/dev/sdh`).
    original_disk_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .new_disk_name = "newDiskName",
        .original_disk_path = "originalDiskPath",
    };
};
