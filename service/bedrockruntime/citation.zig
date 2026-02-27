const CitationLocation = @import("citation_location.zig").CitationLocation;
const CitationSourceContent = @import("citation_source_content.zig").CitationSourceContent;

/// Contains information about a citation that references a specific source
/// document. Citations provide traceability between the model's generated
/// response and the source documents that informed that response.
pub const Citation = struct {
    /// The precise location within the source document where the cited content can
    /// be found, including character positions, page numbers, or chunk identifiers.
    location: ?CitationLocation,

    /// The source from the original search result that provided the cited content.
    source: ?[]const u8,

    /// The specific content from the source document that was referenced or cited
    /// in the generated response.
    source_content: ?[]const CitationSourceContent,

    /// The title or identifier of the source document being cited.
    title: ?[]const u8,

    pub const json_field_names = .{
        .location = "location",
        .source = "source",
        .source_content = "sourceContent",
        .title = "title",
    };
};
