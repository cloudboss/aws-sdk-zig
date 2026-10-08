const PolicyFirewallType = @import("policy_firewall_type.zig").PolicyFirewallType;
const ScopeResourceType = @import("scope_resource_type.zig").ScopeResourceType;

/// Coverage information for one firewall type within a deployment. It lists the
/// deployment's policies that have this firewall type. It also lists the
/// resource types in the deployment's scope that the firewall type protects.
pub const DeploymentCoverageEntry = struct {
    /// The firewall type that the policies in this entry share.
    firewall_type: PolicyFirewallType,

    /// The resource types in the deployment's scope that this firewall type
    /// protects. This list is empty if the scope does not select any resource types
    /// that the firewall type protects.
    in_scope_resource_types: []const ScopeResourceType,

    /// The Amazon Resource Names (ARNs) of the deployment's policies that have this
    /// firewall type.
    policy_arns: []const []const u8,

    pub const json_field_names = .{
        .firewall_type = "firewallType",
        .in_scope_resource_types = "inScopeResourceTypes",
        .policy_arns = "policyArns",
    };
};
