/// A stateless rule group that is used by the firewall policy.
pub const FirewallPolicyStatelessRuleGroupReferencesDetails = struct {
    /// The order in which to run the stateless rule group.
    priority: ?i32 = null,

    /// The ARN of the stateless rule group.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .priority = "Priority",
        .resource_arn = "ResourceArn",
    };
};
