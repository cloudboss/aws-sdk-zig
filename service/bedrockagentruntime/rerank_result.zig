const RerankDocument = @import("rerank_document.zig").RerankDocument;

/// Contains information about a document that was reranked.
pub const RerankResult = struct {
    /// Contains information about the document.
    document: ?RerankDocument = null,

    /// The original index of the document from the input sources array.
    index: i32,

    /// The relevance score of the document.
    relevance_score: f32,

    pub const json_field_names = .{
        .document = "document",
        .index = "index",
        .relevance_score = "relevanceScore",
    };
};
