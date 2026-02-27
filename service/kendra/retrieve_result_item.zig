const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;
const ScoreAttributes = @import("score_attributes.zig").ScoreAttributes;

/// A single retrieved relevant passage result.
pub const RetrieveResultItem = struct {
    /// The contents of the relevant passage.
    content: ?[]const u8,

    /// An array of document fields/attributes assigned to a document in the search
    /// results.
    /// For example, the document author (`_author`) or the source URI
    /// (`_source_uri`) of the document.
    document_attributes: ?[]const DocumentAttribute,

    /// The identifier of the document.
    document_id: ?[]const u8,

    /// The title of the document.
    document_title: ?[]const u8,

    /// The URI of the original location of the document.
    document_uri: ?[]const u8,

    /// The identifier of the relevant passage result.
    id: ?[]const u8,

    /// The confidence score bucket for a retrieved passage result. The confidence
    /// bucket
    /// provides a relative ranking that indicates how confident Amazon Kendra is
    /// that the
    /// response is relevant to the query.
    score_attributes: ?ScoreAttributes,

    pub const json_field_names = .{
        .content = "Content",
        .document_attributes = "DocumentAttributes",
        .document_id = "DocumentId",
        .document_title = "DocumentTitle",
        .document_uri = "DocumentURI",
        .id = "Id",
        .score_attributes = "ScoreAttributes",
    };
};
