/// Provides information about text documents in an index.
pub const TextDocumentStatistics = struct {
    /// The total size, in bytes, of the indexed documents.
    indexed_text_bytes: ?i64,

    /// The number of text documents indexed.
    indexed_text_document_count: ?i32,

    pub const json_field_names = .{
        .indexed_text_bytes = "indexedTextBytes",
        .indexed_text_document_count = "indexedTextDocumentCount",
    };
};
