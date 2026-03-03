/// The template summary.
pub const TemplateSummary = struct {
    /// A summary of a template.
    arn: ?[]const u8 = null,

    /// The last time that this template was created.
    created_time: ?i64 = null,

    /// The last time that this template was updated.
    last_updated_time: ?i64 = null,

    /// A structure containing a list of version numbers for the template summary.
    latest_version_number: ?i64 = null,

    /// A display name for the template.
    name: ?[]const u8 = null,

    /// The ID of the template. This ID is unique per Amazon Web Services Region for
    /// each Amazon Web Services account.
    template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .last_updated_time = "LastUpdatedTime",
        .latest_version_number = "LatestVersionNumber",
        .name = "Name",
        .template_id = "TemplateId",
    };
};
