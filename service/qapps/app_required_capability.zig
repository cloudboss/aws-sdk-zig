pub const AppRequiredCapability = enum {
    file_upload,
    creator_mode,
    retrieval_mode,
    plugin_mode,

    pub const json_field_names = .{
        .file_upload = "FILE_UPLOAD",
        .creator_mode = "CREATOR_MODE",
        .retrieval_mode = "RETRIEVAL_MODE",
        .plugin_mode = "PLUGIN_MODE",
    };
};
