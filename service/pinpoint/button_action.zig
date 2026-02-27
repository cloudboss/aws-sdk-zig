pub const ButtonAction = enum {
    link,
    deep_link,
    close,

    pub const json_field_names = .{
        .link = "LINK",
        .deep_link = "DEEP_LINK",
        .close = "CLOSE",
    };
};
