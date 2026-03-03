/// Contains information about the health checks that are conducted on the load
/// balancer.
pub const AwsElbLoadBalancerHealthCheck = struct {
    /// The number of consecutive health check successes required before the
    /// instance is moved
    /// to the Healthy state.
    healthy_threshold: ?i32 = null,

    /// The approximate interval, in seconds, between health checks of an individual
    /// instance.
    interval: ?i32 = null,

    /// The instance that is being checked. The target specifies the protocol and
    /// port. The
    /// available protocols are TCP, SSL, HTTP, and HTTPS. The range of valid ports
    /// is 1 through
    /// 65535.
    ///
    /// For the HTTP and HTTPS protocols, the target also specifies the ping path.
    ///
    /// For the TCP protocol, the target is specified as `TCP:
    /// **
    /// `.
    ///
    /// For the SSL protocol, the target is specified as
    /// `SSL.**
    /// `.
    ///
    /// For the HTTP and HTTPS protocols, the target is specified as
    /// `
    /// **:**/**
    /// `.
    target: ?[]const u8 = null,

    /// The amount of time, in seconds, during which no response means a failed
    /// health
    /// check.
    timeout: ?i32 = null,

    /// The number of consecutive health check failures that must occur before the
    /// instance is
    /// moved to the Unhealthy state.
    unhealthy_threshold: ?i32 = null,

    pub const json_field_names = .{
        .healthy_threshold = "HealthyThreshold",
        .interval = "Interval",
        .target = "Target",
        .timeout = "Timeout",
        .unhealthy_threshold = "UnhealthyThreshold",
    };
};
