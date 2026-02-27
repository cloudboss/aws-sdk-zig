pub const UtcTiming = enum {
    none,
    http_head,
    http_iso,
    http_xsdate,

    pub const json_field_names = .{
        .none = "NONE",
        .http_head = "HTTP_HEAD",
        .http_iso = "HTTP_ISO",
        .http_xsdate = "HTTP_XSDATE",
    };
};
