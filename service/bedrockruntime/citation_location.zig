const DocumentCharLocation = @import("document_char_location.zig").DocumentCharLocation;
const DocumentChunkLocation = @import("document_chunk_location.zig").DocumentChunkLocation;
const DocumentPageLocation = @import("document_page_location.zig").DocumentPageLocation;
const SearchResultLocation = @import("search_result_location.zig").SearchResultLocation;
const WebLocation = @import("web_location.zig").WebLocation;

/// Specifies the precise location within a source document where cited content
/// can be found. This can include character-level positions, page numbers, or
/// document chunks depending on the document type and indexing method.
pub const CitationLocation = union(enum) {
    /// The character-level location within the document where the cited content is
    /// found.
    document_char: ?DocumentCharLocation,
    /// The chunk-level location within the document where the cited content is
    /// found, typically used for documents that have been segmented into logical
    /// chunks.
    document_chunk: ?DocumentChunkLocation,
    /// The page-level location within the document where the cited content is
    /// found.
    document_page: ?DocumentPageLocation,
    /// The search result location where the cited content is found, including the
    /// search result index and block positions within the content array.
    search_result_location: ?SearchResultLocation,
    /// The web URL that was cited for this reference.
    web: ?WebLocation,

    pub const json_field_names = .{
        .document_char = "documentChar",
        .document_chunk = "documentChunk",
        .document_page = "documentPage",
        .search_result_location = "searchResultLocation",
        .web = "web",
    };
};
