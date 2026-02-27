pub const DocumentClassifierDocumentTypeFormat = enum {
    plain_text_document,
    semi_structured_document,

    pub const json_field_names = .{
        .plain_text_document = "PLAIN_TEXT_DOCUMENT",
        .semi_structured_document = "SEMI_STRUCTURED_DOCUMENT",
    };
};
