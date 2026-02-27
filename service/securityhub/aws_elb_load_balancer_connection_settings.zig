/// Contains connection settings for the load balancer.
pub const AwsElbLoadBalancerConnectionSettings = struct {
    /// The time, in seconds, that the connection can be idle (no data is sent over
    /// the
    /// connection) before it is closed by the load balancer.
    idle_timeout: ?i32,

    pub const json_field_names = .{
        .idle_timeout = "IdleTimeout",
    };
};
