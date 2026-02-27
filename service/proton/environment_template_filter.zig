/// A search filter for environment templates.
pub const EnvironmentTemplateFilter = struct {
    /// Include `majorVersion` to filter search for a major version.
    major_version: []const u8,

    /// Include `templateName` to filter search for a template name.
    template_name: []const u8,

    pub const json_field_names = .{
        .major_version = "majorVersion",
        .template_name = "templateName",
    };
};
