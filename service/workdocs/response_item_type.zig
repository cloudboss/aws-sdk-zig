pub const ResponseItemType = enum {
    document,
    folder,
    comment,
    document_version,

    pub const json_field_names = .{
        .document = "DOCUMENT",
        .folder = "FOLDER",
        .comment = "COMMENT",
        .document_version = "DOCUMENT_VERSION",
    };
};
