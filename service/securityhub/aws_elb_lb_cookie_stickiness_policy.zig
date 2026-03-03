/// Contains information about a stickiness policy that was created using
/// `CreateLBCookieStickinessPolicy`.
pub const AwsElbLbCookieStickinessPolicy = struct {
    /// The amount of time, in seconds, after which the cookie is considered stale.
    /// If an
    /// expiration period is not specified, the stickiness session lasts for the
    /// duration of the
    /// browser session.
    cookie_expiration_period: ?i64 = null,

    /// The name of the policy. The name must be unique within the set of policies
    /// for the load
    /// balancer.
    policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cookie_expiration_period = "CookieExpirationPeriod",
        .policy_name = "PolicyName",
    };
};
