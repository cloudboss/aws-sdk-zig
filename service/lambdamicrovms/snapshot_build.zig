/// Contains size information about a MicroVM image snapshot build.
pub const SnapshotBuild = struct {
    /// The size of the installed code in bytes.
    code_install_size_in_bytes: ?i64 = null,

    /// The size of the disk snapshot in bytes.
    disk_snapshot_size_in_bytes: ?i64 = null,

    /// The size of the memory snapshot in bytes.
    memory_snapshot_size_in_bytes: ?i64 = null,

    pub const json_field_names = .{
        .code_install_size_in_bytes = "codeInstallSizeInBytes",
        .disk_snapshot_size_in_bytes = "diskSnapshotSizeInBytes",
        .memory_snapshot_size_in_bytes = "memorySnapshotSizeInBytes",
    };
};
