/// An object that represents a type of connection pool.
pub const VirtualGatewayHttpConnectionPool = struct {
    /// Maximum number of outbound TCP connections Envoy can establish concurrently
    /// with all
    /// hosts in upstream cluster.
    max_connections: i32,

    /// Number of overflowing requests after `max_connections` Envoy will queue to
    /// upstream cluster.
    max_pending_requests: ?i32 = null,

    pub const json_field_names = .{
        .max_connections = "maxConnections",
        .max_pending_requests = "maxPendingRequests",
    };
};
