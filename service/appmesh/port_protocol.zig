pub const PortProtocol = enum {
    http,
    tcp,
    http2,
    grpc,

    pub const json_field_names = .{
        .http = "HTTP",
        .tcp = "TCP",
        .http2 = "HTTP2",
        .grpc = "GRPC",
    };
};
