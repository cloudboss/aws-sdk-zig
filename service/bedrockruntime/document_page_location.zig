/// Specifies a page-level location within a document, providing positioning
/// information for cited content using page numbers.
pub const DocumentPageLocation = struct {
    /// The index of the document within the array of documents provided in the
    /// request.
    document_index: ?i32 = null,

    /// The ending page number of the cited content within the document.
    end: ?i32 = null,

    /// The starting page number of the cited content within the document.
    start: ?i32 = null,

    pub const json_field_names = .{
        .document_index = "documentIndex",
        .end = "end",
        .start = "start",
    };
};
