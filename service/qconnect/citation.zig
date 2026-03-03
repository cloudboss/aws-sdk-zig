const CitationSpan = @import("citation_span.zig").CitationSpan;
const ReferenceType = @import("reference_type.zig").ReferenceType;

/// A citation that references source content.
pub const Citation = struct {
    citation_span: CitationSpan,

    /// The identifier of the content being cited.
    content_id: ?[]const u8 = null,

    /// The identifier of the knowledge base containing the cited content.
    knowledge_base_id: ?[]const u8 = null,

    /// A type to define the KB origin of a cited content
    reference_type: ReferenceType,

    /// The source URL for the citation.
    source_url: ?[]const u8 = null,

    /// The title of the cited content.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .citation_span = "citationSpan",
        .content_id = "contentId",
        .knowledge_base_id = "knowledgeBaseId",
        .reference_type = "referenceType",
        .source_url = "sourceURL",
        .title = "title",
    };
};
