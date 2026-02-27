/// Contains information on where a code vulnerability is located in your Lambda
/// function.
pub const CodeFilePath = struct {
    /// The line number of the last line of code that a vulnerability was found in.
    end_line: i32,

    /// The name of the file the code vulnerability was found in.
    file_name: []const u8,

    /// The file path to the code that a vulnerability was found in.
    file_path: []const u8,

    /// The line number of the first line of code that a vulnerability was found in.
    start_line: i32,

    pub const json_field_names = .{
        .end_line = "endLine",
        .file_name = "fileName",
        .file_path = "filePath",
        .start_line = "startLine",
    };
};
