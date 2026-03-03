const SecurityGroupRuleRequest = @import("security_group_rule_request.zig").SecurityGroupRuleRequest;

/// Describes an update to a security group rule.
pub const SecurityGroupRuleUpdate = struct {
    /// Information about the security group rule.
    security_group_rule: ?SecurityGroupRuleRequest = null,

    /// The ID of the security group rule.
    security_group_rule_id: []const u8,
};
