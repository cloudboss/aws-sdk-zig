pub const HealthCheckProtocol = enum {
    tcp,
    http,
    https,

    pub const json_field_names = .{
        .tcp = "TCP",
        .http = "HTTP",
        .https = "HTTPS",
    };
};
