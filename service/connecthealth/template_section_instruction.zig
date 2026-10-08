/// Instructions for generating a specific section of a clinical note
pub const TemplateSectionInstruction = struct {
    /// The header for this section of the template
    section_header: []const u8,

    /// The instruction for generating this section
    section_instruction: []const u8,

    pub const json_field_names = .{
        .section_header = "sectionHeader",
        .section_instruction = "sectionInstruction",
    };
};
