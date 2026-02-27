const SnippetExcerpt = @import("snippet_excerpt.zig").SnippetExcerpt;
const SourceDetails = @import("source_details.zig").SourceDetails;

/// Provides information about a text extract in a chat response that can be
/// attributed to a source document.
pub const TextSegment = struct {
    /// The zero-based location in the response string where the source attribution
    /// starts.
    begin_offset: ?i32,

    /// The zero-based location in the response string where the source attribution
    /// ends.
    end_offset: ?i32,

    /// The identifier of the media object associated with the text segment in the
    /// source attribution.
    media_id: ?[]const u8,

    /// The MIME type (image/png) of the media object associated with the text
    /// segment in the source attribution.
    media_mime_type: ?[]const u8,

    /// The relevant text excerpt from a source that was used to generate a citation
    /// text segment in an Amazon Q Business chat response.
    snippet_excerpt: ?SnippetExcerpt,

    /// Source information for a segment of extracted text, including its media
    /// type.
    source_details: ?SourceDetails,

    pub const json_field_names = .{
        .begin_offset = "beginOffset",
        .end_offset = "endOffset",
        .media_id = "mediaId",
        .media_mime_type = "mediaMimeType",
        .snippet_excerpt = "snippetExcerpt",
        .source_details = "sourceDetails",
    };
};
