pub const DefaultDocumentIdFormat = enum {
    firehose_default,
    no_document_id,

    pub const json_field_names = .{
        .firehose_default = "FIREHOSE_DEFAULT",
        .no_document_id = "NO_DOCUMENT_ID",
    };
};
