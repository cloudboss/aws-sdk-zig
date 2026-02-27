/// Returns information about errors in a BatchDescribeMergeConflicts operation.
pub const BatchDescribeMergeConflictsError = struct {
    /// The name of the exception.
    exception_name: []const u8,

    /// The path to the file.
    file_path: []const u8,

    /// The message provided by the exception.
    message: []const u8,

    pub const json_field_names = .{
        .exception_name = "exceptionName",
        .file_path = "filePath",
        .message = "message",
    };
};
