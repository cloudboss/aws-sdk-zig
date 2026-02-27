pub const DocumentType = enum {
    native_pdf,
    scanned_pdf,
    ms_word,
    image,
    plain_text,
    textract_detect_document_text_json,
    textract_analyze_document_json,

    pub const json_field_names = .{
        .native_pdf = "NATIVE_PDF",
        .scanned_pdf = "SCANNED_PDF",
        .ms_word = "MS_WORD",
        .image = "IMAGE",
        .plain_text = "PLAIN_TEXT",
        .textract_detect_document_text_json = "TEXTRACT_DETECT_DOCUMENT_TEXT_JSON",
        .textract_analyze_document_json = "TEXTRACT_ANALYZE_DOCUMENT_JSON",
    };
};
