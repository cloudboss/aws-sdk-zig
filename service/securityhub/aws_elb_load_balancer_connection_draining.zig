/// Contains information about the connection draining configuration for the
/// load
/// balancer.
pub const AwsElbLoadBalancerConnectionDraining = struct {
    /// Indicates whether connection draining is enabled for the load balancer.
    enabled: ?bool,

    /// The maximum time, in seconds, to keep the existing connections open before
    /// deregistering
    /// the instances.
    timeout: ?i32,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .timeout = "Timeout",
    };
};
