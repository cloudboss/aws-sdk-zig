/// Contains information about a stickiness policy that was created using
/// `CreateAppCookieStickinessPolicy`.
pub const AwsElbAppCookieStickinessPolicy = struct {
    /// The name of the application cookie used for stickiness.
    cookie_name: ?[]const u8,

    /// The mnemonic name for the policy being created. The name must be unique
    /// within the set
    /// of policies for the load balancer.
    policy_name: ?[]const u8,

    pub const json_field_names = .{
        .cookie_name = "CookieName",
        .policy_name = "PolicyName",
    };
};
