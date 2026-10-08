const PrivacyBudget = @import("privacy_budget.zig").PrivacyBudget;
const PrivacyBudgetType = @import("privacy_budget_type.zig").PrivacyBudgetType;

/// A summary of the collaboration privacy budgets. This summary includes the
/// collaboration information, creation information, epsilon provided, and
/// utility in terms of aggregations.
pub const CollaborationPrivacyBudgetSummary = struct {
    /// The includes epsilon provided and utility in terms of aggregations.
    budget: PrivacyBudget,

    /// The ARN of the collaboration that includes this privacy budget.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that includes this privacy
    /// budget.
    collaboration_id: []const u8,

    /// The time at which the privacy budget was created.
    create_time: i64,

    /// The unique identifier of the account that created this privacy budget.
    creator_account_id: []const u8,

    /// The unique identifier of the collaboration privacy budget.
    id: []const u8,

    /// The ARN of the collaboration privacy budget template.
    privacy_budget_template_arn: []const u8,

    /// The unique identifier of the collaboration privacy budget template.
    privacy_budget_template_id: []const u8,

    /// The type of privacy budget template.
    type: PrivacyBudgetType,

    /// The most recent time at which the privacy budget was updated.
    update_time: i64,

    pub const json_field_names = .{
        .budget = "budget",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .id = "id",
        .privacy_budget_template_arn = "privacyBudgetTemplateArn",
        .privacy_budget_template_id = "privacyBudgetTemplateId",
        .type = "type",
        .update_time = "updateTime",
    };
};
