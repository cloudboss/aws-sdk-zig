const NetworkFirewallPolicyDescription = @import("network_firewall_policy_description.zig").NetworkFirewallPolicyDescription;

/// Violation detail for Network Firewall for a firewall policy that has a
/// different
/// NetworkFirewallPolicyDescription than is required by the Firewall Manager
/// policy.
pub const NetworkFirewallPolicyModifiedViolation = struct {
    /// The policy that's currently in use in the individual account.
    current_policy_description: ?NetworkFirewallPolicyDescription,

    /// The policy that should be in use in the individual account in order to be
    /// compliant.
    expected_policy_description: ?NetworkFirewallPolicyDescription,

    /// The ID of the Network Firewall or VPC resource that's in violation.
    violation_target: ?[]const u8,

    pub const json_field_names = .{
        .current_policy_description = "CurrentPolicyDescription",
        .expected_policy_description = "ExpectedPolicyDescription",
        .violation_target = "ViolationTarget",
    };
};
