/// Identifies where the sensitive data begins and ends.
pub const Range = struct {
    /// The number of lines (for a line range) or characters (for an offset range)
    /// from the beginning of the file to the end of the sensitive data.
    end: ?i64 = null,

    /// The number of lines (for a line range) or characters (for an offset range)
    /// from the beginning of the file to the end of the sensitive data.
    start: ?i64 = null,

    /// In the line where the sensitive data starts, the column within the line
    /// where the sensitive data starts.
    start_column: ?i64 = null,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
        .start_column = "StartColumn",
    };
};
