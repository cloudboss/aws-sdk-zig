/// Contains information about an email template.
pub const EmailTemplateMetadata = struct {
    /// The time and date the template was created.
    created_timestamp: ?i64,

    /// The name of the template.
    template_name: ?[]const u8,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .template_name = "TemplateName",
    };
};
