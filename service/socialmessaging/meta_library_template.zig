const LibraryTemplateBodyInputs = @import("library_template_body_inputs.zig").LibraryTemplateBodyInputs;
const LibraryTemplateButtonInput = @import("library_template_button_input.zig").LibraryTemplateButtonInput;

/// Represents a template from Meta's library with customization options.
pub const MetaLibraryTemplate = struct {
    /// Body text customizations for the template.
    library_template_body_inputs: ?LibraryTemplateBodyInputs = null,

    /// Button customizations for the template.
    library_template_button_inputs: ?[]const LibraryTemplateButtonInput = null,

    /// The name of the template in Meta's library.
    library_template_name: []const u8,

    /// The category of the template (for example, UTILITY or MARKETING).
    template_category: []const u8,

    /// The language code for the template (for example, en_US).
    template_language: []const u8,

    /// The name to assign to the template.
    template_name: []const u8,

    pub const json_field_names = .{
        .library_template_body_inputs = "libraryTemplateBodyInputs",
        .library_template_button_inputs = "libraryTemplateButtonInputs",
        .library_template_name = "libraryTemplateName",
        .template_category = "templateCategory",
        .template_language = "templateLanguage",
        .template_name = "templateName",
    };
};
