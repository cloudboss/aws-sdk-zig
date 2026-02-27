/// A file containing a batch job definition.
pub const FileBatchJobDefinition = struct {
    /// The name of the file containing the batch job definition.
    file_name: []const u8,

    /// The path to the file containing the batch job definition.
    folder_path: ?[]const u8,

    pub const json_field_names = .{
        .file_name = "fileName",
        .folder_path = "folderPath",
    };
};
