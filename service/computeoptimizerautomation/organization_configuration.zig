const RuleApplyOrder = @import("rule_apply_order.zig").RuleApplyOrder;

/// Configuration settings for organization-wide automation rules.
pub const OrganizationConfiguration = struct {
    /// List of specific Amazon Web Services account IDs where the organization rule
    /// should be applied.
    account_ids: ?[]const []const u8,

    /// Specifies when organization rules should be applied relative to account
    /// rules.
    rule_apply_order: ?RuleApplyOrder,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .rule_apply_order = "ruleApplyOrder",
    };
};
