const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;
const TextWithHighlights = @import("text_with_highlights.zig").TextWithHighlights;

/// A single expanded result in a collapsed group of search results.
///
/// An expanded result item contains information about an expanded result
/// document within
/// a collapsed group of search results. This includes the original location of
/// the
/// document, a list of attributes assigned to the document, and relevant text
/// from the
/// document that satisfies the query.
pub const ExpandedResultItem = struct {
    /// An array of document attributes assigned to a document in the search
    /// results. For
    /// example, the document author ("_author") or the source URI ("_source_uri")
    /// of the
    /// document.
    document_attributes: ?[]const DocumentAttribute = null,

    document_excerpt: ?TextWithHighlights = null,

    /// The idenitifier of the document.
    document_id: ?[]const u8 = null,

    document_title: ?TextWithHighlights = null,

    /// The URI of the original location of the document.
    document_uri: ?[]const u8 = null,

    /// The identifier for the expanded result.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .document_attributes = "DocumentAttributes",
        .document_excerpt = "DocumentExcerpt",
        .document_id = "DocumentId",
        .document_title = "DocumentTitle",
        .document_uri = "DocumentURI",
        .id = "Id",
    };
};
