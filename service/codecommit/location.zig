const RelativeFileVersionEnum = @import("relative_file_version_enum.zig").RelativeFileVersionEnum;

/// Returns information about the location of a change or comment in the
/// comparison between two commits or a pull request.
pub const Location = struct {
    /// The name of the file being compared, including its extension and
    /// subdirectory, if any.
    file_path: ?[]const u8 = null,

    /// The position of a change in a compared file, in line number format.
    file_position: ?i64 = null,

    /// In a comparison of commits or a pull request, whether the change is in the
    /// before or
    /// after of that comparison.
    relative_file_version: ?RelativeFileVersionEnum = null,

    pub const json_field_names = .{
        .file_path = "filePath",
        .file_position = "filePosition",
        .relative_file_version = "relativeFileVersion",
    };
};
