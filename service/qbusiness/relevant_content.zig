const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;
const ScoreAttributes = @import("score_attributes.zig").ScoreAttributes;

/// Represents a piece of content that is relevant to a search query.
pub const RelevantContent = struct {
    /// The actual content of the relevant item.
    content: ?[]const u8 = null,

    /// Additional attributes of the document containing the relevant content.
    document_attributes: ?[]const DocumentAttribute = null,

    /// The unique identifier of the document containing the relevant content.
    document_id: ?[]const u8 = null,

    /// The title of the document containing the relevant content.
    document_title: ?[]const u8 = null,

    /// The URI of the document containing the relevant content.
    document_uri: ?[]const u8 = null,

    /// Attributes related to the relevance score of the content.
    score_attributes: ?ScoreAttributes = null,

    pub const json_field_names = .{
        .content = "content",
        .document_attributes = "documentAttributes",
        .document_id = "documentId",
        .document_title = "documentTitle",
        .document_uri = "documentUri",
        .score_attributes = "scoreAttributes",
    };
};
