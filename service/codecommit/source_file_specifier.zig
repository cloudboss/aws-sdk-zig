/// Information about a source file that is part of changes made in a commit.
pub const SourceFileSpecifier = struct {
    /// The full path to the file, including the name of the file.
    file_path: []const u8,

    /// Whether to remove the source file from the parent commit.
    is_move: bool = false,

    pub const json_field_names = .{
        .file_path = "filePath",
        .is_move = "isMove",
    };
};
