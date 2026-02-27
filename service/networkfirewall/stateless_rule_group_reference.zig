/// Identifier for a single stateless rule group, used in a firewall policy to
/// refer to the
/// rule group.
pub const StatelessRuleGroupReference = struct {
    /// An integer setting that indicates the order in which to run the stateless
    /// rule groups in
    /// a single FirewallPolicy. Network Firewall applies each stateless rule group
    /// to a packet starting with the group that has the lowest priority setting.
    /// You must ensure
    /// that the priority settings are unique within each policy.
    priority: i32,

    /// The Amazon Resource Name (ARN) of the stateless rule group.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .priority = "Priority",
        .resource_arn = "ResourceArn",
    };
};
