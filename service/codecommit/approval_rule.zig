const OriginApprovalRuleTemplate = @import("origin_approval_rule_template.zig").OriginApprovalRuleTemplate;

/// Returns information about an approval rule.
pub const ApprovalRule = struct {
    /// The content of the approval rule.
    approval_rule_content: ?[]const u8 = null,

    /// The system-generated ID of the approval rule.
    approval_rule_id: ?[]const u8 = null,

    /// The name of the approval rule.
    approval_rule_name: ?[]const u8 = null,

    /// The date the approval rule was created, in timestamp format.
    creation_date: ?i64 = null,

    /// The date the approval rule was most recently changed, in timestamp format.
    last_modified_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the user who made the most recent changes
    /// to the approval rule.
    last_modified_user: ?[]const u8 = null,

    /// The approval rule template used to create the rule.
    origin_approval_rule_template: ?OriginApprovalRuleTemplate = null,

    /// The SHA-256 hash signature for the content of the approval rule.
    rule_content_sha_256: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_rule_content = "approvalRuleContent",
        .approval_rule_id = "approvalRuleId",
        .approval_rule_name = "approvalRuleName",
        .creation_date = "creationDate",
        .last_modified_date = "lastModifiedDate",
        .last_modified_user = "lastModifiedUser",
        .origin_approval_rule_template = "originApprovalRuleTemplate",
        .rule_content_sha_256 = "ruleContentSha256",
    };
};
