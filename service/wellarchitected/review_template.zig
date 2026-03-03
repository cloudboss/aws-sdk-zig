const aws = @import("aws");

const ReviewTemplateUpdateStatus = @import("review_template_update_status.zig").ReviewTemplateUpdateStatus;

/// A review template.
pub const ReviewTemplate = struct {
    /// The review template description.
    description: ?[]const u8 = null,

    /// The lenses applied to the review template.
    lenses: ?[]const []const u8 = null,

    notes: ?[]const u8 = null,

    owner: ?[]const u8 = null,

    /// A count of how many total questions are answered and unanswered in the
    /// review template.
    question_counts: ?[]const aws.map.MapEntry(i32) = null,

    /// The ID assigned to the template share invitation.
    share_invitation_id: ?[]const u8 = null,

    /// The tags assigned to the review template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The review template ARN.
    template_arn: ?[]const u8 = null,

    /// The name of the review template.
    template_name: ?[]const u8 = null,

    updated_at: ?i64 = null,

    /// The latest status of a review template.
    update_status: ?ReviewTemplateUpdateStatus = null,

    pub const json_field_names = .{
        .description = "Description",
        .lenses = "Lenses",
        .notes = "Notes",
        .owner = "Owner",
        .question_counts = "QuestionCounts",
        .share_invitation_id = "ShareInvitationId",
        .tags = "Tags",
        .template_arn = "TemplateArn",
        .template_name = "TemplateName",
        .updated_at = "UpdatedAt",
        .update_status = "UpdateStatus",
    };
};
