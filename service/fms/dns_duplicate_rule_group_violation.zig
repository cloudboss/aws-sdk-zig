/// A DNS Firewall rule group that Firewall Manager
/// tried to associate with a VPC is already associated with the VPC and can't
/// be associated again.
pub const DnsDuplicateRuleGroupViolation = struct {
    /// Information about the VPC ID.
    violation_target: ?[]const u8,

    /// A description of the violation that specifies the rule group and VPC.
    violation_target_description: ?[]const u8,

    pub const json_field_names = .{
        .violation_target = "ViolationTarget",
        .violation_target_description = "ViolationTargetDescription",
    };
};
