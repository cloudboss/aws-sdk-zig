const AutomatedReasoningPolicyAnnotatedContent = @import("automated_reasoning_policy_annotated_content.zig").AutomatedReasoningPolicyAnnotatedContent;

/// Represents a portion of a source document with line number annotations.
/// Chunks help organize document content for easier navigation and reference.
pub const AutomatedReasoningPolicyAnnotatedChunk = struct {
    /// The lines of text contained within this chunk, each annotated with its line
    /// number.
    content: []const AutomatedReasoningPolicyAnnotatedContent,

    /// The page number where this chunk begins, if the document is divided into
    /// pages.
    page_number: ?i32 = null,

    pub const json_field_names = .{
        .content = "content",
        .page_number = "pageNumber",
    };
};
