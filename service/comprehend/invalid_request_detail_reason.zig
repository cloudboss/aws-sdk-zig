pub const InvalidRequestDetailReason = enum {
    document_size_exceeded,
    unsupported_doc_type,
    page_limit_exceeded,
    textract_access_denied,

    pub const json_field_names = .{
        .document_size_exceeded = "DOCUMENT_SIZE_EXCEEDED",
        .unsupported_doc_type = "UNSUPPORTED_DOC_TYPE",
        .page_limit_exceeded = "PAGE_LIMIT_EXCEEDED",
        .textract_access_denied = "TEXTRACT_ACCESS_DENIED",
    };
};
