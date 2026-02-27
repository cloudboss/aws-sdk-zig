/// Specifies the location of an occurrence of sensitive data in an email
/// message or a non-binary text file such as an HTML, TXT, or XML file.
pub const Range = struct {
    /// The number of lines from the beginning of the file to the end of the
    /// sensitive data.
    end: ?i64,

    /// The number of lines from the beginning of the file to the beginning of the
    /// sensitive data.
    start: ?i64,

    /// The number of characters, with spaces and starting from 1, from the
    /// beginning of the first line that contains the sensitive data (start) to the
    /// beginning of the sensitive data.
    start_column: ?i64,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
        .start_column = "startColumn",
    };
};
