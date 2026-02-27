pub const SearchResourceType = enum {
    folder,
    document,
    comment,
    document_version,

    pub const json_field_names = .{
        .folder = "FOLDER",
        .document = "DOCUMENT",
        .comment = "COMMENT",
        .document_version = "DOCUMENT_VERSION",
    };
};
