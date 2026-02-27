pub const MessageFilterType = enum {
    all,
    text_only,

    pub const json_field_names = .{
        .all = "ALL",
        .text_only = "TEXT_ONLY",
    };
};
