pub const ApplicationProtocol = enum {
    http,
    http2,
    grpc,

    pub const json_field_names = .{
        .http = "HTTP",
        .http2 = "HTTP2",
        .grpc = "GRPC",
    };
};
