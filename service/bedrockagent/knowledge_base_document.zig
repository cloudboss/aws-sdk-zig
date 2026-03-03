const DocumentContent = @import("document_content.zig").DocumentContent;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;

/// Contains information about a document to ingest into a knowledge base and
/// metadata to associate with it.
pub const KnowledgeBaseDocument = struct {
    /// Contains the content of the document.
    content: DocumentContent,

    /// Contains the metadata to associate with the document.
    metadata: ?DocumentMetadata = null,

    pub const json_field_names = .{
        .content = "content",
        .metadata = "metadata",
    };
};
