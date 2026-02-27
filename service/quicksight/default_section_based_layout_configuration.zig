const SectionBasedLayoutCanvasSizeOptions = @import("section_based_layout_canvas_size_options.zig").SectionBasedLayoutCanvasSizeOptions;

/// The options that determine the default settings for a section-based layout
/// configuration.
pub const DefaultSectionBasedLayoutConfiguration = struct {
    /// Determines the screen canvas size options for a section-based layout.
    canvas_size_options: SectionBasedLayoutCanvasSizeOptions,

    pub const json_field_names = .{
        .canvas_size_options = "CanvasSizeOptions",
    };
};
