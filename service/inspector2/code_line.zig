/// Contains information on the lines of code associated with a code snippet.
pub const CodeLine = struct {
    /// The content of a line of code
    content: []const u8,

    /// The line number that a section of code is located at.
    line_number: i32,

    pub const json_field_names = .{
        .content = "content",
        .line_number = "lineNumber",
    };
};
