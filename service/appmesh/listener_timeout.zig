const GrpcTimeout = @import("grpc_timeout.zig").GrpcTimeout;
const HttpTimeout = @import("http_timeout.zig").HttpTimeout;
const TcpTimeout = @import("tcp_timeout.zig").TcpTimeout;

/// An object that represents timeouts for different protocols.
pub const ListenerTimeout = union(enum) {
    /// An object that represents types of timeouts.
    grpc: ?GrpcTimeout,
    /// An object that represents types of timeouts.
    http: ?HttpTimeout,
    /// An object that represents types of timeouts.
    http_2: ?HttpTimeout,
    /// An object that represents types of timeouts.
    tcp: ?TcpTimeout,

    pub const json_field_names = .{
        .grpc = "grpc",
        .http = "http",
        .http_2 = "http2",
        .tcp = "tcp",
    };
};
