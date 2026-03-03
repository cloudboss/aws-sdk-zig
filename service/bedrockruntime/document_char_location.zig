/// Specifies a character-level location within a document, providing precise
/// positioning information for cited content using start and end character
/// indices.
pub const DocumentCharLocation = struct {
    /// The index of the document within the array of documents provided in the
    /// request.
    document_index: ?i32 = null,

    /// The ending character position of the cited content within the document.
    end: ?i32 = null,

    /// The starting character position of the cited content within the document.
    start: ?i32 = null,

    pub const json_field_names = .{
        .document_index = "documentIndex",
        .end = "end",
        .start = "start",
    };
};
