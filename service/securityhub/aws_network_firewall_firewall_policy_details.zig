const FirewallPolicyDetails = @import("firewall_policy_details.zig").FirewallPolicyDetails;

/// Details about a firewall policy. A firewall policy defines the behavior of a
/// network firewall.
pub const AwsNetworkFirewallFirewallPolicyDetails = struct {
    /// A description of the firewall policy.
    description: ?[]const u8,

    /// The firewall policy configuration.
    firewall_policy: ?FirewallPolicyDetails,

    /// The ARN of the firewall policy.
    firewall_policy_arn: ?[]const u8,

    /// The identifier of the firewall policy.
    firewall_policy_id: ?[]const u8,

    /// The name of the firewall policy.
    firewall_policy_name: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .firewall_policy = "FirewallPolicy",
        .firewall_policy_arn = "FirewallPolicyArn",
        .firewall_policy_id = "FirewallPolicyId",
        .firewall_policy_name = "FirewallPolicyName",
    };
};
