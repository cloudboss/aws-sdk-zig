pub const DnsResponseType = enum {
    loadbalancer,
    endpoints,

    pub const json_field_names = .{
        .loadbalancer = "LOADBALANCER",
        .endpoints = "ENDPOINTS",
    };
};
