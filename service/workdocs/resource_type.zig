pub const ResourceType = enum {
    folder,
    document,

    pub const json_field_names = .{
        .folder = "FOLDER",
        .document = "DOCUMENT",
    };
};
