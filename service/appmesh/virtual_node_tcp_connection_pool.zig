/// An object that represents a type of connection pool.
pub const VirtualNodeTcpConnectionPool = struct {
    /// Maximum number of outbound TCP connections Envoy can establish concurrently
    /// with all
    /// hosts in upstream cluster.
    max_connections: i32,

    pub const json_field_names = .{
        .max_connections = "maxConnections",
    };
};
