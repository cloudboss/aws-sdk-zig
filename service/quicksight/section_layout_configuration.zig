const FreeFormSectionLayoutConfiguration = @import("free_form_section_layout_configuration.zig").FreeFormSectionLayoutConfiguration;

/// The layout configuration of a section.
pub const SectionLayoutConfiguration = struct {
    /// The free-form layout configuration of a section.
    free_form_layout: FreeFormSectionLayoutConfiguration,

    pub const json_field_names = .{
        .free_form_layout = "FreeFormLayout",
    };
};
