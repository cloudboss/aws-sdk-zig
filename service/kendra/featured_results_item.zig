const AdditionalResultAttribute = @import("additional_result_attribute.zig").AdditionalResultAttribute;
const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;
const TextWithHighlights = @import("text_with_highlights.zig").TextWithHighlights;
const QueryResultType = @import("query_result_type.zig").QueryResultType;

/// A single featured result item. A featured result is displayed at the top of
/// the search results page, placed above all other results for certain queries.
/// If
/// there's an exact match of a query, then certain documents are featured in
/// the
/// search results.
pub const FeaturedResultsItem = struct {
    /// One or more additional attributes associated with the featured result.
    additional_attributes: ?[]const AdditionalResultAttribute = null,

    /// An array of document attributes assigned to a featured document in the
    /// search results. For example, the document author (`_author`) or
    /// the source URI (`_source_uri`) of the document.
    document_attributes: ?[]const DocumentAttribute = null,

    document_excerpt: ?TextWithHighlights = null,

    /// The identifier of the featured document.
    document_id: ?[]const u8 = null,

    document_title: ?TextWithHighlights = null,

    /// The source URI location of the featured document.
    document_uri: ?[]const u8 = null,

    /// A token that identifies a particular featured result from a particular
    /// query. Use this token to provide click-through feedback for the result.
    /// For more information, see [Submitting
    /// feedback](https://docs.aws.amazon.com/kendra/latest/dg/submitting-feedback.html).
    feedback_token: ?[]const u8 = null,

    /// The identifier of the featured result.
    id: ?[]const u8 = null,

    /// The type of document within the featured result response. For example,
    /// a response could include a question-answer type that's relevant to the
    /// query.
    @"type": ?QueryResultType = null,

    pub const json_field_names = .{
        .additional_attributes = "AdditionalAttributes",
        .document_attributes = "DocumentAttributes",
        .document_excerpt = "DocumentExcerpt",
        .document_id = "DocumentId",
        .document_title = "DocumentTitle",
        .document_uri = "DocumentURI",
        .feedback_token = "FeedbackToken",
        .id = "Id",
        .@"type" = "Type",
    };
};
