/// Contains information about an email template.
pub const TemplateMetadata = struct {
    /// The time and date the template was created.
    created_timestamp: ?i64,

    /// The name of the template.
    name: ?[]const u8,
};
