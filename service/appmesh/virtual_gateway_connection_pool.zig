const VirtualGatewayGrpcConnectionPool = @import("virtual_gateway_grpc_connection_pool.zig").VirtualGatewayGrpcConnectionPool;
const VirtualGatewayHttpConnectionPool = @import("virtual_gateway_http_connection_pool.zig").VirtualGatewayHttpConnectionPool;
const VirtualGatewayHttp2ConnectionPool = @import("virtual_gateway_http_2_connection_pool.zig").VirtualGatewayHttp2ConnectionPool;

/// An object that represents the type of virtual gateway connection pool.
///
/// Only one protocol is used at a time and should be the same protocol as the
/// one chosen
/// under port mapping.
///
/// If not present the default value for `maxPendingRequests` is
/// `2147483647`.
pub const VirtualGatewayConnectionPool = union(enum) {
    /// An object that represents a type of connection pool.
    grpc: ?VirtualGatewayGrpcConnectionPool,
    /// An object that represents a type of connection pool.
    http: ?VirtualGatewayHttpConnectionPool,
    /// An object that represents a type of connection pool.
    http_2: ?VirtualGatewayHttp2ConnectionPool,

    pub const json_field_names = .{
        .grpc = "grpc",
        .http = "http",
        .http_2 = "http2",
    };
};
