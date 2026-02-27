pub const MessageFormat = enum {
    raw,
    json,

    pub const json_field_names = .{
        .raw = "RAW",
        .json = "JSON",
    };
};
