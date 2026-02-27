const RerankDocument = @import("rerank_document.zig").RerankDocument;
const RerankSourceType = @import("rerank_source_type.zig").RerankSourceType;

/// Contains information about a source for reranking.
pub const RerankSource = struct {
    /// Contains an inline definition of a source for reranking.
    inline_document_source: RerankDocument,

    /// The type of the source.
    type: RerankSourceType,

    pub const json_field_names = .{
        .inline_document_source = "inlineDocumentSource",
        .type = "type",
    };
};
