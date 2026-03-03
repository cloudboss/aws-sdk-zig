/// Information about a policy for duration-based session stickiness.
pub const LBCookieStickinessPolicy = struct {
    /// The time period, in seconds, after which the cookie should be considered
    /// stale. If this parameter is not specified, the stickiness session lasts for
    /// the duration of the browser session.
    cookie_expiration_period: ?i64 = null,

    /// The name of the policy. This name must be unique within the set of policies
    /// for this load balancer.
    policy_name: ?[]const u8 = null,
};
