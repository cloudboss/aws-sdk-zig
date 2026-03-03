const FileModeTypeEnum = @import("file_mode_type_enum.zig").FileModeTypeEnum;
const SourceFileSpecifier = @import("source_file_specifier.zig").SourceFileSpecifier;

/// Information about a file added or updated as part of a commit.
pub const PutFileEntry = struct {
    /// The content of the file, if a source file is not specified.
    file_content: ?[]const u8 = null,

    /// The extrapolated file mode permissions for the file. Valid values include
    /// EXECUTABLE and NORMAL.
    file_mode: ?FileModeTypeEnum = null,

    /// The full path to the file in the repository, including the name of the file.
    file_path: []const u8,

    /// The name and full path of the file that contains the changes you want to
    /// make as part of the commit,
    /// if you are not providing the file content directly.
    source_file: ?SourceFileSpecifier = null,

    pub const json_field_names = .{
        .file_content = "fileContent",
        .file_mode = "fileMode",
        .file_path = "filePath",
        .source_file = "sourceFile",
    };
};
