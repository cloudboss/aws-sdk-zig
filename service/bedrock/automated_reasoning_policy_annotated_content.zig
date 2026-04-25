const AutomatedReasoningPolicyAnnotatedLine = @import("automated_reasoning_policy_annotated_line.zig").AutomatedReasoningPolicyAnnotatedLine;

/// Represents a content element within an annotated chunk. This union type
/// allows for different types of content elements to be included in document
/// chunks, such as individual lines of text with their line numbers.
pub const AutomatedReasoningPolicyAnnotatedContent = union(enum) {
    /// An annotated line of text from the source document, including both the line
    /// number and the text content.
    line: ?AutomatedReasoningPolicyAnnotatedLine,

    pub const json_field_names = .{
        .line = "line",
    };
};
