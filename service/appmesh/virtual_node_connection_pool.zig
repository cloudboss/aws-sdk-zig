const VirtualNodeGrpcConnectionPool = @import("virtual_node_grpc_connection_pool.zig").VirtualNodeGrpcConnectionPool;
const VirtualNodeHttpConnectionPool = @import("virtual_node_http_connection_pool.zig").VirtualNodeHttpConnectionPool;
const VirtualNodeHttp2ConnectionPool = @import("virtual_node_http_2_connection_pool.zig").VirtualNodeHttp2ConnectionPool;
const VirtualNodeTcpConnectionPool = @import("virtual_node_tcp_connection_pool.zig").VirtualNodeTcpConnectionPool;

/// An object that represents the type of virtual node connection pool.
///
/// Only one protocol is used at a time and should be the same protocol as the
/// one chosen
/// under port mapping.
///
/// If not present the default value for `maxPendingRequests` is
/// `2147483647`.
pub const VirtualNodeConnectionPool = union(enum) {
    /// An object that represents a type of connection pool.
    grpc: ?VirtualNodeGrpcConnectionPool,
    /// An object that represents a type of connection pool.
    http: ?VirtualNodeHttpConnectionPool,
    /// An object that represents a type of connection pool.
    http_2: ?VirtualNodeHttp2ConnectionPool,
    /// An object that represents a type of connection pool.
    tcp: ?VirtualNodeTcpConnectionPool,

    pub const json_field_names = .{
        .grpc = "grpc",
        .http = "http",
        .http_2 = "http2",
        .tcp = "tcp",
    };
};
