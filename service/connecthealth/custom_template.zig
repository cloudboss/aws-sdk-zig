const TemplateSectionInstruction = @import("template_section_instruction.zig").TemplateSectionInstruction;
const CustomTemplateBase = @import("custom_template_base.zig").CustomTemplateBase;

/// Configuration for using a custom note template with specific instructions
pub const CustomTemplate = struct {
    /// Custom instructions for each section of the template
    template_instructions: []const TemplateSectionInstruction,

    /// The base template type to customize
    template_type: CustomTemplateBase,

    pub const json_field_names = .{
        .template_instructions = "templateInstructions",
        .template_type = "templateType",
    };
};
