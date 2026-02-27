const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;

/// Information about the file mode changes.
pub const SetFileModeEntry = struct {
    /// The file mode for the file.
    file_mode: FileModeTypeEnum,

    /// The full path to the file, including the name of the file.
    file_path: []const u8,

    pub const json_field_names = .{
        .file_mode = "fileMode",
        .file_path = "filePath",
    };
};
