const KbTemplateConfiguration = @import("kb_template_configuration.zig").KbTemplateConfiguration;

/// The configuration settings for a knowledge base.
pub const KnowledgeBaseConfiguration = struct {
    /// The template configuration that defines how the data source connector crawls
    /// and indexes data for the knowledge base. The template structure varies by
    /// connector type. See `KbTemplateConfiguration` for connector-specific
    /// details.
    template_configuration: ?KbTemplateConfiguration = null,

    pub const json_field_names = .{
        .template_configuration = "templateConfiguration",
    };
};
