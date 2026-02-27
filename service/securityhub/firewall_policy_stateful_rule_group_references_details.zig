/// A stateful rule group that is used by the firewall policy.
pub const FirewallPolicyStatefulRuleGroupReferencesDetails = struct {
    /// The ARN of the stateful rule group.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
