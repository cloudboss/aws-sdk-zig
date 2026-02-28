const RerankTextDocument = @import("rerank_text_document.zig").RerankTextDocument;
const RerankDocumentType = @import("rerank_document_type.zig").RerankDocumentType;

/// Contains information about a document to rerank. Choose the `type` to define
/// and include the field that corresponds to the type.
pub const RerankDocument = struct {
    /// Contains a JSON document to rerank.
    json_document: ?[]const u8,

    /// Contains information about a text document to rerank.
    text_document: ?RerankTextDocument,

    /// The type of document to rerank.
    type: RerankDocumentType,

    pub const json_field_names = .{
        .json_document = "jsonDocument",
        .text_document = "textDocument",
        .type = "type",
    };
};
