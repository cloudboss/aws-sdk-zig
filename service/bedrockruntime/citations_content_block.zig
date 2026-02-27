const Citation = @import("citation.zig").Citation;
const CitationGeneratedContent = @import("citation_generated_content.zig").CitationGeneratedContent;

/// A content block that contains both generated text and associated citation
/// information. This block type is returned when document citations are
/// enabled, providing traceability between the generated content and the source
/// documents that informed the response.
pub const CitationsContentBlock = struct {
    /// An array of citations that reference the source documents used to generate
    /// the associated content.
    citations: ?[]const Citation,

    /// The generated content that is supported by the associated citations.
    content: ?[]const CitationGeneratedContent,

    pub const json_field_names = .{
        .citations = "citations",
        .content = "content",
    };
};
