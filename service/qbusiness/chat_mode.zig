pub const ChatMode = enum {
    retrieval_mode,
    creator_mode,
    plugin_mode,

    pub const json_field_names = .{
        .retrieval_mode = "RETRIEVAL_MODE",
        .creator_mode = "CREATOR_MODE",
        .plugin_mode = "PLUGIN_MODE",
    };
};
