/// Describes a block storage disk that is attached to an instance, and is
/// included in an
/// automatic snapshot.
pub const AttachedDisk = struct {
    /// The path of the disk (`/dev/xvdf`).
    path: ?[]const u8,

    /// The size of the disk in GB.
    size_in_gb: ?i32,

    pub const json_field_names = .{
        .path = "path",
        .size_in_gb = "sizeInGb",
    };
};
