pub const DashUtcTimingMode = enum {
    http_head,
    http_iso,
    http_xsdate,
    utc_direct,

    pub const json_field_names = .{
        .http_head = "HTTP_HEAD",
        .http_iso = "HTTP_ISO",
        .http_xsdate = "HTTP_XSDATE",
        .utc_direct = "UTC_DIRECT",
    };
};
