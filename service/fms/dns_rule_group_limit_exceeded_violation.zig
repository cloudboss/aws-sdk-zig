/// The VPC that Firewall Manager was applying a DNS Fireall policy to reached
/// the limit for associated DNS Firewall rule groups. Firewall Manager tried to
/// associate another rule group with the VPC and failed due to the limit.
pub const DnsRuleGroupLimitExceededViolation = struct {
    /// The number of rule groups currently associated with the VPC.
    number_of_rule_groups_already_associated: i32 = 0,

    /// Information about the VPC ID.
    violation_target: ?[]const u8 = null,

    /// A description of the violation that specifies the rule group and VPC.
    violation_target_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .number_of_rule_groups_already_associated = "NumberOfRuleGroupsAlreadyAssociated",
        .violation_target = "ViolationTarget",
        .violation_target_description = "ViolationTargetDescription",
    };
};
