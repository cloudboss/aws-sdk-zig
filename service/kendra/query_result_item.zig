const AdditionalResultAttribute = @import("additional_result_attribute.zig").AdditionalResultAttribute;
const CollapsedResultDetail = @import("collapsed_result_detail.zig").CollapsedResultDetail;
const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;
const TextWithHighlights = @import("text_with_highlights.zig").TextWithHighlights;
const QueryResultFormat = @import("query_result_format.zig").QueryResultFormat;
const ScoreAttributes = @import("score_attributes.zig").ScoreAttributes;
const TableExcerpt = @import("table_excerpt.zig").TableExcerpt;
const QueryResultType = @import("query_result_type.zig").QueryResultType;

/// A single query result.
///
/// A query result contains information about a document returned by the query.
/// This
/// includes the original location of the document, a list of attributes
/// assigned to the
/// document, and relevant text from the document that satisfies the query.
pub const QueryResultItem = struct {
    /// One or more additional fields/attributes associated with the query result.
    additional_attributes: ?[]const AdditionalResultAttribute,

    /// Provides details about a collapsed group of search results.
    collapsed_result_detail: ?CollapsedResultDetail,

    /// An array of document fields/attributes assigned to a document in the search
    /// results. For
    /// example, the document author (`_author`) or the source URI
    /// (`_source_uri`) of the document.
    document_attributes: ?[]const DocumentAttribute,

    /// An extract of the text in the document. Contains information about
    /// highlighting the
    /// relevant terms in the excerpt.
    document_excerpt: ?TextWithHighlights,

    /// The identifier for the document.
    document_id: ?[]const u8,

    /// The title of the document. Contains the text of the title and information
    /// for
    /// highlighting the relevant terms in the title.
    document_title: ?TextWithHighlights,

    /// The URI of the original location of the document.
    document_uri: ?[]const u8,

    /// A token that identifies a particular result from a particular query. Use
    /// this token to
    /// provide click-through feedback for the result. For more information, see
    /// [Submitting
    /// feedback](https://docs.aws.amazon.com/kendra/latest/dg/submitting-feedback.html).
    feedback_token: ?[]const u8,

    /// If the `Type` of document within the response is `ANSWER`, then it
    /// is either a `TABLE` answer or `TEXT` answer. If it's a table answer,
    /// a table excerpt is returned in `TableExcerpt`. If it's a text answer, a text
    /// excerpt is returned in `DocumentExcerpt`.
    format: ?QueryResultFormat,

    /// The unique identifier for the query result item id (`Id`) and the query
    /// result item document id (`DocumentId`) combined. The value of this field
    /// changes
    /// with every request, even when you have the same documents.
    id: ?[]const u8,

    /// Indicates the confidence level of Amazon Kendra providing a relevant result
    /// for the
    /// query. Each result is placed into a bin that indicates the confidence,
    /// `VERY_HIGH`, `HIGH`, `MEDIUM` and `LOW`. You
    /// can use the score to determine if a response meets the confidence needed for
    /// your
    /// application.
    ///
    /// The field is only set to `LOW` when the `Type` field is set to
    /// `DOCUMENT` and Amazon Kendra is not confident that the result is
    /// relevant to the query.
    score_attributes: ?ScoreAttributes,

    /// An excerpt from a table within a document.
    table_excerpt: ?TableExcerpt,

    /// The type of document within the response. For example, a response could
    /// include a
    /// question-answer that's relevant to the query.
    @"type": ?QueryResultType,

    pub const json_field_names = .{
        .additional_attributes = "AdditionalAttributes",
        .collapsed_result_detail = "CollapsedResultDetail",
        .document_attributes = "DocumentAttributes",
        .document_excerpt = "DocumentExcerpt",
        .document_id = "DocumentId",
        .document_title = "DocumentTitle",
        .document_uri = "DocumentURI",
        .feedback_token = "FeedbackToken",
        .format = "Format",
        .id = "Id",
        .score_attributes = "ScoreAttributes",
        .table_excerpt = "TableExcerpt",
        .@"type" = "Type",
    };
};
