const NetworkAclCommonPolicy = @import("network_acl_common_policy.zig").NetworkAclCommonPolicy;
const NetworkFirewallPolicy = @import("network_firewall_policy.zig").NetworkFirewallPolicy;
const ThirdPartyFirewallPolicy = @import("third_party_firewall_policy.zig").ThirdPartyFirewallPolicy;

/// Contains the settings to configure a network ACL policy, a Network Firewall
/// firewall policy deployment model, or a third-party firewall policy.
pub const PolicyOption = struct {
    /// Defines a Firewall Manager network ACL policy.
    network_acl_common_policy: ?NetworkAclCommonPolicy,

    /// Defines the deployment model to use for the firewall policy.
    network_firewall_policy: ?NetworkFirewallPolicy,

    /// Defines the policy options for a third-party firewall policy.
    third_party_firewall_policy: ?ThirdPartyFirewallPolicy,

    pub const json_field_names = .{
        .network_acl_common_policy = "NetworkAclCommonPolicy",
        .network_firewall_policy = "NetworkFirewallPolicy",
        .third_party_firewall_policy = "ThirdPartyFirewallPolicy",
    };
};
