const FreeFormLayoutElement = @import("free_form_layout_element.zig").FreeFormLayoutElement;

/// The free-form layout configuration of a section.
pub const FreeFormSectionLayoutConfiguration = struct {
    /// The elements that are included in the free-form layout.
    elements: []const FreeFormLayoutElement,

    pub const json_field_names = .{
        .elements = "Elements",
    };
};
