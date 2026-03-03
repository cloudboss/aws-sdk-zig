const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;

/// A file to be added, updated, or deleted as part of a commit.
pub const FileMetadata = struct {
    /// The full path to the file to be added or updated, including the name of the
    /// file.
    absolute_path: ?[]const u8 = null,

    /// The blob ID that contains the file information.
    blob_id: ?[]const u8 = null,

    /// The extrapolated file mode permissions for the file. Valid values include
    /// EXECUTABLE and NORMAL.
    file_mode: ?FileModeTypeEnum = null,

    pub const json_field_names = .{
        .absolute_path = "absolutePath",
        .blob_id = "blobId",
        .file_mode = "fileMode",
    };
};
