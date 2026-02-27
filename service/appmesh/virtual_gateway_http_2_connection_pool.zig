/// An object that represents a type of connection pool.
pub const VirtualGatewayHttp2ConnectionPool = struct {
    /// Maximum number of inflight requests Envoy can concurrently support across
    /// hosts in
    /// upstream cluster.
    max_requests: i32,

    pub const json_field_names = .{
        .max_requests = "maxRequests",
    };
};
