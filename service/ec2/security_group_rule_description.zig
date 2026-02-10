/// Describes the description of a security group rule.
///
/// You can use this when you want to update the security group rule description
/// for either an inbound or outbound rule.
pub const SecurityGroupRuleDescription = struct {
    /// The description of the security group rule.
    description: ?[]const u8,

    /// The ID of the security group rule.
    security_group_rule_id: ?[]const u8,
};
