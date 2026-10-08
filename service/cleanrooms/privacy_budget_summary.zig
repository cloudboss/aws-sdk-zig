const PrivacyBudget = @import("privacy_budget.zig").PrivacyBudget;
const PrivacyBudgetType = @import("privacy_budget_type.zig").PrivacyBudgetType;

/// An array that summaries the specified privacy budget. This summary includes
/// collaboration information, creation information, membership information, and
/// privacy budget information.
pub const PrivacyBudgetSummary = struct {
    /// The provided privacy budget.
    budget: PrivacyBudget,

    /// The ARN of the collaboration that contains this privacy budget.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains this privacy
    /// budget.
    collaboration_id: []const u8,

    /// The time at which the privacy budget was created.
    create_time: i64,

    /// The unique identifier of the privacy budget.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the member who created the privacy budget
    /// summary.
    membership_arn: []const u8,

    /// The identifier for a membership resource.
    membership_id: []const u8,

    /// The ARN of the privacy budget template.
    privacy_budget_template_arn: []const u8,

    /// The unique identifier of the privacy budget template.
    privacy_budget_template_id: []const u8,

    /// Specifies the type of the privacy budget.
    type: PrivacyBudgetType,

    /// The most recent time at which the privacy budget was updated.
    update_time: i64,

    pub const json_field_names = .{
        .budget = "budget",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .privacy_budget_template_arn = "privacyBudgetTemplateArn",
        .privacy_budget_template_id = "privacyBudgetTemplateId",
        .type = "type",
        .update_time = "updateTime",
    };
};
