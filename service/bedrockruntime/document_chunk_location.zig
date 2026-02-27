/// Specifies a chunk-level location within a document, providing positioning
/// information for cited content using logical document segments or chunks.
pub const DocumentChunkLocation = struct {
    /// The index of the document within the array of documents provided in the
    /// request.
    document_index: ?i32,

    /// The ending chunk identifier or index of the cited content within the
    /// document.
    end: ?i32,

    /// The starting chunk identifier or index of the cited content within the
    /// document.
    start: ?i32,

    pub const json_field_names = .{
        .document_index = "documentIndex",
        .end = "end",
        .start = "start",
    };
};
