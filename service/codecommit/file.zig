const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;

/// Returns information about a file in a repository.
pub const File = struct {
    /// The fully qualified path to the file in the repository.
    absolute_path: ?[]const u8,

    /// The blob ID that contains the file information.
    blob_id: ?[]const u8,

    /// The extrapolated file mode permissions for the file. Valid values include
    /// EXECUTABLE and NORMAL.
    file_mode: ?FileModeTypeEnum,

    /// The relative path of the file from the folder where the query originated.
    relative_path: ?[]const u8,

    pub const json_field_names = .{
        .absolute_path = "absolutePath",
        .blob_id = "blobId",
        .file_mode = "fileMode",
        .relative_path = "relativePath",
    };
};
