pub const AlfrescoEntity = enum {
    wiki,
    blog,
    document_library,

    pub const json_field_names = .{
        .wiki = "wiki",
        .blog = "blog",
        .document_library = "documentLibrary",
    };
};
