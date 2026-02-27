/// A file that is deleted as part of a commit.
pub const DeleteFileEntry = struct {
    /// The full path of the file to be deleted, including the name of the file.
    file_path: []const u8,

    pub const json_field_names = .{
        .file_path = "filePath",
    };
};
