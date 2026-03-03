const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;

/// Returns information about a symbolic link in a repository folder.
pub const SymbolicLink = struct {
    /// The fully qualified path to the folder that contains the symbolic link.
    absolute_path: ?[]const u8 = null,

    /// The blob ID that contains the information about the symbolic link.
    blob_id: ?[]const u8 = null,

    /// The file mode permissions of the blob that cotains information about the
    /// symbolic link.
    file_mode: ?FileModeTypeEnum = null,

    /// The relative path of the symbolic link from the folder where the query
    /// originated.
    relative_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .absolute_path = "absolutePath",
        .blob_id = "blobId",
        .file_mode = "fileMode",
        .relative_path = "relativePath",
    };
};
