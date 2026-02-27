pub const FolderContentType = enum {
    all,
    document,
    folder,

    pub const json_field_names = .{
        .all = "ALL",
        .document = "DOCUMENT",
        .folder = "FOLDER",
    };
};
