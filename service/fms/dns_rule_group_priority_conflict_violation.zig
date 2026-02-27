/// A rule group that Firewall Manager
/// tried to associate with a VPC has the same priority as a rule group that's
/// already associated.
pub const DnsRuleGroupPriorityConflictViolation = struct {
    /// The ID of the Firewall Manager DNS Firewall policy that was already applied
    /// to the VPC.
    /// This policy contains the rule group that's already associated with the VPC.
    conflicting_policy_id: ?[]const u8,

    /// The priority setting of the two conflicting rule groups.
    conflicting_priority: i32 = 0,

    /// The priorities of rule groups that are already associated with the VPC. To
    /// retry your operation,
    /// choose priority settings that aren't in this list for the rule groups in
    /// your new DNS Firewall policy.
    unavailable_priorities: ?[]const i32,

    /// Information about the VPC ID.
    violation_target: ?[]const u8,

    /// A description of the violation that specifies the VPC and the rule group
    /// that's already associated with it.
    violation_target_description: ?[]const u8,

    pub const json_field_names = .{
        .conflicting_policy_id = "ConflictingPolicyId",
        .conflicting_priority = "ConflictingPriority",
        .unavailable_priorities = "UnavailablePriorities",
        .violation_target = "ViolationTarget",
        .violation_target_description = "ViolationTargetDescription",
    };
};
