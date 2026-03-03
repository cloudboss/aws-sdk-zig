const ReviewTemplateUpdateStatus = @import("review_template_update_status.zig").ReviewTemplateUpdateStatus;

/// Summary of a review template.
pub const ReviewTemplateSummary = struct {
    /// Description of the review template.
    description: ?[]const u8 = null,

    /// Lenses associated with the review template.
    lenses: ?[]const []const u8 = null,

    owner: ?[]const u8 = null,

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
        .owner = "Owner",
        .template_arn = "TemplateArn",
        .template_name = "TemplateName",
        .updated_at = "UpdatedAt",
        .update_status = "UpdateStatus",
    };
};
