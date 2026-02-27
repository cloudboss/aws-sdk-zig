/// Information about the `ConnectionSettings` attribute.
pub const ConnectionSettings = struct {
    /// The time, in seconds, that the connection is allowed to be idle (no data has
    /// been sent over the connection) before it is closed by the load balancer.
    idle_timeout: i32,
};
