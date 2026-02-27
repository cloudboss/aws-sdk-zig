/// Information about a policy for application-controlled session stickiness.
pub const AppCookieStickinessPolicy = struct {
    /// The name of the application cookie used for stickiness.
    cookie_name: ?[]const u8,

    /// The mnemonic name for the policy being created. The name must be unique
    /// within a set of policies for this load balancer.
    policy_name: ?[]const u8,
};
