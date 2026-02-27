pub const Action = enum {
    open_app,
    deep_link,
    url,

    pub const json_field_names = .{
        .open_app = "OPEN_APP",
        .deep_link = "DEEP_LINK",
        .url = "URL",
    };
};
