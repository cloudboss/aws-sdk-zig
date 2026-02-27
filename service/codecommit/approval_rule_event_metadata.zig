/// Returns information about an event for an approval rule.
pub const ApprovalRuleEventMetadata = struct {
    /// The content of the approval rule.
    approval_rule_content: ?[]const u8,

    /// The system-generated ID of the approval rule.
    approval_rule_id: ?[]const u8,

    /// The name of the approval rule.
    approval_rule_name: ?[]const u8,

    pub const json_field_names = .{
        .approval_rule_content = "approvalRuleContent",
        .approval_rule_id = "approvalRuleId",
        .approval_rule_name = "approvalRuleName",
    };
};
