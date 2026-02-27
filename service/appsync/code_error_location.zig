/// Describes the location of the error in a code sample.
pub const CodeErrorLocation = struct {
    /// The column number in the code. Defaults to `0` if unknown.
    column: i32 = 0,

    /// The line number in the code. Defaults to `0` if unknown.
    line: i32 = 0,

    /// The span/length of the error. Defaults to `-1` if unknown.
    span: i32 = 0,

    pub const json_field_names = .{
        .column = "column",
        .line = "line",
        .span = "span",
    };
};
