pub const HealthCheckProtocolVersion = enum {
    /// Indicates use of HTTP/1.1 to send requests to target
    http1,
    /// Indicates use of HTTP/2 to send requests to target
    http2,

    pub const json_field_names = .{
        .http1 = "HTTP1",
        .http2 = "HTTP2",
    };
};
