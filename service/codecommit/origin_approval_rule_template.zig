/// Returns information about the template that created the approval rule for a
/// pull request.
pub const OriginApprovalRuleTemplate = struct {
    /// The ID of the template that created the approval rule.
    approval_rule_template_id: ?[]const u8 = null,

    /// The name of the template that created the approval rule.
    approval_rule_template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_rule_template_id = "approvalRuleTemplateId",
        .approval_rule_template_name = "approvalRuleTemplateName",
    };
};
