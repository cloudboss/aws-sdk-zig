const PrivacyBudgetType = @import("privacy_budget_type.zig").PrivacyBudgetType;

/// A summary of the privacy budget template. The summary includes membership
/// information, collaboration information, and creation information.
pub const PrivacyBudgetTemplateSummary = struct {
    /// The ARN of the privacy budget template.
    arn: []const u8,

    /// The ARN of the collaboration that contains this privacy budget template.
    collaboration_arn: []const u8,

    /// The unique ID of the collaboration that contains this privacy budget
    /// template.
    collaboration_id: []const u8,

    /// The time at which the privacy budget template was created.
    create_time: i64,

    /// The unique identifier of the privacy budget template.
    id: []const u8,

    /// The Amazon Resource Name (ARN) of the member who created the privacy budget
    /// template.
    membership_arn: []const u8,

    /// The identifier for a membership resource.
    membership_id: []const u8,

    /// The type of the privacy budget template.
    privacy_budget_type: PrivacyBudgetType,

    /// The most recent time at which the privacy budget template was updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .id = "id",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .privacy_budget_type = "privacyBudgetType",
        .update_time = "updateTime",
    };
};
