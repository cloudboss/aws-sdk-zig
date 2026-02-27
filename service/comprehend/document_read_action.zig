pub const DocumentReadAction = enum {
    textract_detect_document_text,
    textract_analyze_document,

    pub const json_field_names = .{
        .textract_detect_document_text = "TEXTRACT_DETECT_DOCUMENT_TEXT",
        .textract_analyze_document = "TEXTRACT_ANALYZE_DOCUMENT",
    };
};
