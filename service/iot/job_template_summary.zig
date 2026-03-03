/// An object that contains information about the job template.
pub const JobTemplateSummary = struct {
    /// The time, in seconds since the epoch, when the job template was created.
    created_at: ?i64 = null,

    /// A description of the job template.
    description: ?[]const u8 = null,

    /// The ARN of the job template.
    job_template_arn: ?[]const u8 = null,

    /// The unique identifier of the job template.
    job_template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .job_template_arn = "jobTemplateArn",
        .job_template_id = "jobTemplateId",
    };
};
