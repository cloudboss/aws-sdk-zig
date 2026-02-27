/// Provides information about text documents indexed in an index.
pub const TextDocumentStatistics = struct {
    /// The total size, in bytes, of the indexed documents.
    indexed_text_bytes: i64 = 0,

    /// The number of text documents indexed.
    indexed_text_documents_count: i32 = 0,

    pub const json_field_names = .{
        .indexed_text_bytes = "IndexedTextBytes",
        .indexed_text_documents_count = "IndexedTextDocumentsCount",
    };
};
