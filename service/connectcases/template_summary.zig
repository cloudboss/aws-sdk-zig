const TemplateStatus = @import("template_status.zig").TemplateStatus;
const TagPropagationConfiguration = @import("tag_propagation_configuration.zig").TagPropagationConfiguration;

/// Template summary information.
pub const TemplateSummary = struct {
    /// The template name.
    name: []const u8,

    /// The status of the template.
    status: TemplateStatus,

    /// Defines tag propagation configuration for resources created within a domain.
    /// Tags specified here will be automatically applied to resources being created
    /// for the specified resource type.
    tag_propagation_configurations: ?[]const TagPropagationConfiguration = null,

    /// The Amazon Resource Name (ARN) of the template.
    template_arn: []const u8,

    /// The unique identifier for the template.
    template_id: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .status = "status",
        .tag_propagation_configurations = "tagPropagationConfigurations",
        .template_arn = "templateArn",
        .template_id = "templateId",
    };
};
