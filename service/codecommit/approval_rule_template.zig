/// Returns information about an approval rule template.
pub const ApprovalRuleTemplate = struct {
    /// The content of the approval rule template.
    approval_rule_template_content: ?[]const u8 = null,

    /// The description of the approval rule template.
    approval_rule_template_description: ?[]const u8 = null,

    /// The system-generated ID of the approval rule template.
    approval_rule_template_id: ?[]const u8 = null,

    /// The name of the approval rule template.
    approval_rule_template_name: ?[]const u8 = null,

    /// The date the approval rule template was created, in timestamp format.
    creation_date: ?i64 = null,

    /// The date the approval rule template was most recently changed, in timestamp
    /// format.
    last_modified_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the user who made the most recent changes
    /// to the approval rule template.
    last_modified_user: ?[]const u8 = null,

    /// The SHA-256 hash signature for the content of the approval rule template.
    rule_content_sha_256: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_rule_template_content = "approvalRuleTemplateContent",
        .approval_rule_template_description = "approvalRuleTemplateDescription",
        .approval_rule_template_id = "approvalRuleTemplateId",
        .approval_rule_template_name = "approvalRuleTemplateName",
        .creation_date = "creationDate",
        .last_modified_date = "lastModifiedDate",
        .last_modified_user = "lastModifiedUser",
        .rule_content_sha_256 = "ruleContentSha256",
    };
};
