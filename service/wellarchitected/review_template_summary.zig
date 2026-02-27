const ReviewTemplateUpdateStatus = @import("review_template_update_status.zig").ReviewTemplateUpdateStatus;

/// Summary of a review template.
pub const ReviewTemplateSummary = struct {
    /// Description of the review template.
    description: ?[]const u8,

    /// Lenses associated with the review template.
    lenses: ?[]const []const u8,

    owner: ?[]const u8,

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
        .owner = "Owner",
        .template_arn = "TemplateArn",
        .template_name = "TemplateName",
        .updated_at = "UpdatedAt",
        .update_status = "UpdateStatus",
    };
};
