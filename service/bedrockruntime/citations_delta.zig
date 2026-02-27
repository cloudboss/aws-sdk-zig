const CitationLocation = @import("citation_location.zig").CitationLocation;
const CitationSourceContentDelta = @import("citation_source_content_delta.zig").CitationSourceContentDelta;

/// Contains incremental updates to citation information during streaming
/// responses. This allows clients to build up citation data progressively as
/// the response is generated.
pub const CitationsDelta = struct {
    /// Specifies the precise location within a source document where cited content
    /// can be found. This can include character-level positions, page numbers, or
    /// document chunks depending on the document type and indexing method.
    location: ?CitationLocation,

    /// The source from the original search result that provided the cited content.
    source: ?[]const u8,

    /// The specific content from the source document that was referenced or cited
    /// in the generated response.
    source_content: ?[]const CitationSourceContentDelta,

    /// The title or identifier of the source document being cited.
    title: ?[]const u8,

    pub const json_field_names = .{
        .location = "location",
        .source = "source",
        .source_content = "sourceContent",
        .title = "title",
    };
};
