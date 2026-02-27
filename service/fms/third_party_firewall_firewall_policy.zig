/// Configures the third-party firewall's firewall policy.
pub const ThirdPartyFirewallFirewallPolicy = struct {
    /// The ID of the specified firewall policy.
    firewall_policy_id: ?[]const u8,

    /// The name of the specified firewall policy.
    firewall_policy_name: ?[]const u8,

    pub const json_field_names = .{
        .firewall_policy_id = "FirewallPolicyId",
        .firewall_policy_name = "FirewallPolicyName",
    };
};
