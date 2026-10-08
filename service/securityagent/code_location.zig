/// Represents a location in source code associated with a security finding.
pub const CodeLocation = struct {
    /// The absolute path to the file containing the code location.
    file_path: []const u8,

    /// The role of this location in the vulnerability, such as source or sink.
    label: ?[]const u8 = null,

    /// The ending line number of the code location.
    line_end: ?i32 = null,

    /// The starting line number of the code location.
    line_start: ?i32 = null,

    pub const json_field_names = .{
        .file_path = "filePath",
        .label = "label",
        .line_end = "lineEnd",
        .line_start = "lineStart",
    };
};
