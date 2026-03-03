/// Provides details about where a code vulnerability is located in your Lambda
/// function.
pub const CodeVulnerabilitiesFilePath = struct {
    /// The line number of the last line of code in which the vulnerability is
    /// located.
    end_line: ?i32 = null,

    /// The name of the file in which the code vulnerability is located.
    file_name: ?[]const u8 = null,

    /// The file path to the code in which the vulnerability is located.
    file_path: ?[]const u8 = null,

    /// The line number of the first line of code in which the vulnerability is
    /// located.
    start_line: ?i32 = null,

    pub const json_field_names = .{
        .end_line = "EndLine",
        .file_name = "FileName",
        .file_path = "FilePath",
        .start_line = "StartLine",
    };
};
