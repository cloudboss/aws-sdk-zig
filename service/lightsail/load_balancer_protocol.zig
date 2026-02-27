pub const LoadBalancerProtocol = enum {
    http_https,
    http,

    pub const json_field_names = .{
        .http_https = "HTTP_HTTPS",
        .http = "HTTP",
    };
};
