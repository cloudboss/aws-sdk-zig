const PrivacyBudgetType = @import("privacy_budget_type.zig").PrivacyBudgetType;

/// A summary of the collaboration's privacy budget template. This summary
/// includes information about who created the privacy budget template and what
/// collaborations it belongs to.
pub const CollaborationPrivacyBudgetTemplateSummary = struct {
    /// The ARN of the collaboration privacy budget template.
    arn: []const u8,

    /// The ARN of the collaboration that contains this collaboration privacy budget
    /// template.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains this collaboration
    /// privacy budget template.
    collaboration_id: []const u8,

    /// The time at which the collaboration privacy budget template was created.
    create_time: i64,

    /// The unique identifier of the account that created this collaboration privacy
    /// budget template.
    creator_account_id: []const u8,

    /// The unique identifier of the collaboration privacy budget template.
    id: []const u8,

    /// The type of the privacy budget template.
    privacy_budget_type: PrivacyBudgetType,

    /// The most recent time at which the collaboration privacy budget template was
    /// updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .creator_account_id = "creatorAccountId",
        .id = "id",
        .privacy_budget_type = "privacyBudgetType",
        .update_time = "updateTime",
    };
};
