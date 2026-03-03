const LibraryTemplateButtonList = @import("library_template_button_list.zig").LibraryTemplateButtonList;

/// Defines the complete structure and content of a template in Meta's library.
pub const MetaLibraryTemplateDefinition = struct {
    /// The body text of the template.
    template_body: ?[]const u8 = null,

    /// Example parameter values for the template body, used to demonstrate how
    /// dynamic content appears in the template.
    template_body_example_params: ?[]const []const u8 = null,

    /// The buttons included in the template.
    template_buttons: ?[]const LibraryTemplateButtonList = null,

    /// The category of the template (for example, UTILITY or MARKETING).
    template_category: ?[]const u8 = null,

    /// The header text of the template.
    template_header: ?[]const u8 = null,

    /// The ID of the template in Meta's library.
    template_id: ?[]const u8 = null,

    /// The industries the template is designed for.
    template_industry: ?[]const []const u8 = null,

    /// The language code for the template (for example, en_US).
    template_language: ?[]const u8 = null,

    /// The name of the template.
    template_name: ?[]const u8 = null,

    /// The topic or subject matter of the template.
    template_topic: ?[]const u8 = null,

    /// The intended use case for the template.
    template_use_case: ?[]const u8 = null,

    pub const json_field_names = .{
        .template_body = "templateBody",
        .template_body_example_params = "templateBodyExampleParams",
        .template_buttons = "templateButtons",
        .template_category = "templateCategory",
        .template_header = "templateHeader",
        .template_id = "templateId",
        .template_industry = "templateIndustry",
        .template_language = "templateLanguage",
        .template_name = "templateName",
        .template_topic = "templateTopic",
        .template_use_case = "templateUseCase",
    };
};
