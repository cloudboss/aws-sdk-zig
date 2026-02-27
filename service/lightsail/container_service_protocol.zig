pub const ContainerServiceProtocol = enum {
    http,
    https,
    tcp,
    udp,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
        .tcp = "TCP",
        .udp = "UDP",
    };
};
