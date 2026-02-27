pub const HealthCheckType = enum {
    http,
    https,
    tcp,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
        .tcp = "TCP",
    };
};
