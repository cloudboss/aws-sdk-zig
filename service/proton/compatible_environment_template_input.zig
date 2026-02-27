/// Compatible environment template data.
pub const CompatibleEnvironmentTemplateInput = struct {
    /// The major version of the compatible environment template.
    major_version: []const u8,

    /// The compatible environment template name.
    template_name: []const u8,

    pub const json_field_names = .{
        .major_version = "majorVersion",
        .template_name = "templateName",
    };
};
