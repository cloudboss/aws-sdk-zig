pub const ServiceType = enum {
    http,
    dns_http,
    dns,

    pub const json_field_names = .{
        .http = "HTTP",
        .dns_http = "DNS_HTTP",
        .dns = "DNS",
    };
};
