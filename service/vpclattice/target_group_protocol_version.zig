pub const TargetGroupProtocolVersion = enum {
    /// Indicates use of HTTP/1.1 to send requests to target
    http1,
    /// Indicates use of HTTP/2 to send requests to target
    http2,
    /// Indicates use of gRPC to send requests to target
    grpc,

    pub const json_field_names = .{
        .http1 = "HTTP1",
        .http2 = "HTTP2",
        .grpc = "GRPC",
    };
};
