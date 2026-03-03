/// A batch job identifier in which the batch job to run is identified by the
/// file name and
/// the relative path to the file name.
pub const FileBatchJobIdentifier = struct {
    /// The file name for the batch job identifier.
    file_name: []const u8,

    /// The relative path to the file name for the batch job identifier.
    folder_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_name = "fileName",
        .folder_path = "folderPath",
    };
};
