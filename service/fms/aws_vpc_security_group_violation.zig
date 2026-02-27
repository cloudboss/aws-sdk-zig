const PartialMatch = @import("partial_match.zig").PartialMatch;
const SecurityGroupRemediationAction = @import("security_group_remediation_action.zig").SecurityGroupRemediationAction;

/// Violation detail for the rule violation in a security group when compared to
/// the primary security group of the Firewall Manager policy.
pub const AwsVPCSecurityGroupViolation = struct {
    /// List of rules specified in the security group of the Firewall Manager policy
    /// that partially match the `ViolationTarget` rule.
    partial_matches: ?[]const PartialMatch,

    /// Remediation options for the rule specified in the `ViolationTarget`.
    possible_security_group_remediation_actions: ?[]const SecurityGroupRemediationAction,

    /// The security group rule that is being evaluated.
    violation_target: ?[]const u8,

    /// A description of the security group that violates the policy.
    violation_target_description: ?[]const u8,

    pub const json_field_names = .{
        .partial_matches = "PartialMatches",
        .possible_security_group_remediation_actions = "PossibleSecurityGroupRemediationActions",
        .violation_target = "ViolationTarget",
        .violation_target_description = "ViolationTargetDescription",
    };
};
