const FileSystemAccessMode = @import("file_system_access_mode.zig").FileSystemAccessMode;
const FileSystemType = @import("file_system_type.zig").FileSystemType;

/// Specifies a file system data source for a channel.
pub const FileSystemDataSource = struct {
    /// The full path to the directory to associate with the channel.
    directory_path: []const u8,

    /// The access mode of the mount of the directory associated with the channel. A
    /// directory can be mounted either in `ro` (read-only) or `rw` (read-write)
    /// mode.
    file_system_access_mode: FileSystemAccessMode,

    /// The file system id.
    file_system_id: []const u8,

    /// The file system type.
    file_system_type: FileSystemType,

    pub const json_field_names = .{
        .directory_path = "DirectoryPath",
        .file_system_access_mode = "FileSystemAccessMode",
        .file_system_id = "FileSystemId",
        .file_system_type = "FileSystemType",
    };
};
