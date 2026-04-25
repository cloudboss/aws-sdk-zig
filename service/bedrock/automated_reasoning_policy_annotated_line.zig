/// Represents a single line of text from a source document, annotated with its
/// line number for precise referencing.
pub const AutomatedReasoningPolicyAnnotatedLine = struct {
    /// The line number of this text within the source document.
    line_number: ?i32 = null,

    /// The actual text content of this line from the source document.
    line_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .line_number = "lineNumber",
        .line_text = "lineText",
    };
};
