const aws = @import("aws");

const ReviewTemplateUpdateStatus = @import("review_template_update_status.zig").ReviewTemplateUpdateStatus;

/// A review template.
pub const ReviewTemplate = struct {
    /// The review template description.
    description: ?[]const u8,

    /// The lenses applied to the review template.
    lenses: ?[]const []const u8,

    notes: ?[]const u8,

    owner: ?[]const u8,

    /// A count of how many total questions are answered and unanswered in the
    /// review template.
    question_counts: ?[]const aws.map.MapEntry(i32),

    /// The ID assigned to the template share invitation.
    share_invitation_id: ?[]const u8,

    /// The tags assigned to the review template.
    tags: ?[]const aws.map.StringMapEntry,

    /// The review template ARN.
    template_arn: ?[]const u8,

    /// The name of the review template.
    template_name: ?[]const u8,

    updated_at: ?i64,

    /// The latest status of a review template.
    update_status: ?ReviewTemplateUpdateStatus,

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
