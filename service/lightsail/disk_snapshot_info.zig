/// Describes a disk snapshot.
pub const DiskSnapshotInfo = struct {
    /// The size of the disk in GB (`32`).
    size_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .size_in_gb = "sizeInGb",
    };
};
