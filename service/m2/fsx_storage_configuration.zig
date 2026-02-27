/// Defines the storage configuration for an Amazon FSx file system.
pub const FsxStorageConfiguration = struct {
    /// The file system identifier.
    file_system_id: []const u8,

    /// The mount point for the file system.
    mount_point: []const u8,

    pub const json_field_names = .{
        .file_system_id = "fileSystemId",
        .mount_point = "mountPoint",
    };
};
