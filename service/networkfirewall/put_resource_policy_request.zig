pub const PutResourcePolicyRequest = struct {
    /// The IAM policy statement that lists the accounts that you want to share your
    /// Network Firewall resources with
    /// and the operations that you want the accounts to be able to perform.
    ///
    /// For a rule group resource, you can specify the following operations in the
    /// Actions section of the statement:
    ///
    /// * network-firewall:CreateFirewallPolicy
    ///
    /// * network-firewall:UpdateFirewallPolicy
    ///
    /// * network-firewall:ListRuleGroups
    ///
    /// For a firewall policy resource, you can specify the following operations in
    /// the Actions section of the statement:
    ///
    /// * network-firewall:AssociateFirewallPolicy
    ///
    /// * network-firewall:ListFirewallPolicies
    ///
    /// For a firewall resource, you can specify the following operations in the
    /// Actions section of the statement:
    ///
    /// * network-firewall:CreateVpcEndpointAssociation
    ///
    /// * network-firewall:DescribeFirewallMetadata
    ///
    /// * network-firewall:ListFirewalls
    ///
    /// In the Resource section of the statement, you specify the ARNs for the
    /// Network Firewall resources that you want to share with the account that you
    /// specified in `Arn`.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the account that you want to share your
    /// Network Firewall resources with.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
