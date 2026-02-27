pub const HealthCheckProtocol = enum {
    tcp,
    http,

    pub const json_field_names = .{
        .tcp = "TCP",
        .http = "HTTP",
    };
};
