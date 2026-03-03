/// An object that contains information about the managed template.
pub const ManagedJobTemplateSummary = struct {
    /// The description for a managed template.
    description: ?[]const u8 = null,

    /// A list of environments that are supported with the managed job template.
    environments: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) for a managed template.
    template_arn: ?[]const u8 = null,

    /// The unique Name for a managed template.
    template_name: ?[]const u8 = null,

    /// The version for a managed template.
    template_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .environments = "environments",
        .template_arn = "templateArn",
        .template_name = "templateName",
        .template_version = "templateVersion",
    };
};
