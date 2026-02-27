const CodeLine = @import("code_line.zig").CodeLine;

/// Information about the location of security vulnerabilities that Amazon
/// CodeGuru Security detected in your code.
pub const FilePath = struct {
    /// A list of `CodeLine` objects that describe where the security vulnerability
    /// appears in your code.
    code_snippet: ?[]const CodeLine,

    /// The last line number of the code snippet where the security vulnerability
    /// appears in your code.
    end_line: ?i32,

    /// The name of the file.
    name: ?[]const u8,

    /// The path to the resource with the security vulnerability.
    path: ?[]const u8,

    /// The first line number of the code snippet where the security vulnerability
    /// appears in your code.
    start_line: ?i32,

    pub const json_field_names = .{
        .code_snippet = "codeSnippet",
        .end_line = "endLine",
        .name = "name",
        .path = "path",
        .start_line = "startLine",
    };
};
