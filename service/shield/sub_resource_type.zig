pub const SubResourceType = enum {
    ip,
    url,

    pub const json_field_names = .{
        .ip = "IP",
        .url = "URL",
    };
};
