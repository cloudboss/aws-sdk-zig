pub const NamespaceType = enum {
    dns_public,
    dns_private,
    http,

    pub const json_field_names = .{
        .dns_public = "DNS_PUBLIC",
        .dns_private = "DNS_PRIVATE",
        .http = "HTTP",
    };
};
