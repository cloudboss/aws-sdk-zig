const SectionLayoutConfiguration = @import("section_layout_configuration.zig").SectionLayoutConfiguration;

/// The configuration of content in a body section.
pub const BodySectionContent = struct {
    /// The layout configuration of a body section.
    layout: ?SectionLayoutConfiguration = null,

    pub const json_field_names = .{
        .layout = "Layout",
    };
};
