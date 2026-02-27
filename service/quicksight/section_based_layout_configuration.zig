const BodySectionConfiguration = @import("body_section_configuration.zig").BodySectionConfiguration;
const SectionBasedLayoutCanvasSizeOptions = @import("section_based_layout_canvas_size_options.zig").SectionBasedLayoutCanvasSizeOptions;
const HeaderFooterSectionConfiguration = @import("header_footer_section_configuration.zig").HeaderFooterSectionConfiguration;

/// The configuration for a
/// section-based layout.
pub const SectionBasedLayoutConfiguration = struct {
    /// A list of body section configurations.
    body_sections: []const BodySectionConfiguration,

    /// The options for the canvas of a section-based layout.
    canvas_size_options: SectionBasedLayoutCanvasSizeOptions,

    /// A list of footer section configurations.
    footer_sections: []const HeaderFooterSectionConfiguration,

    /// A list of header section configurations.
    header_sections: []const HeaderFooterSectionConfiguration,

    pub const json_field_names = .{
        .body_sections = "BodySections",
        .canvas_size_options = "CanvasSizeOptions",
        .footer_sections = "FooterSections",
        .header_sections = "HeaderSections",
    };
};
