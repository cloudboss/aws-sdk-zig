const RerankTextDocument = @import("rerank_text_document.zig").RerankTextDocument;
const RerankQueryContentType = @import("rerank_query_content_type.zig").RerankQueryContentType;

/// Contains information about a query to submit to the reranker model.
pub const RerankQuery = struct {
    /// Contains information about a text query.
    text_query: RerankTextDocument,

    /// The type of the query.
    type: RerankQueryContentType,

    pub const json_field_names = .{
        .text_query = "textQuery",
        .type = "type",
    };
};
