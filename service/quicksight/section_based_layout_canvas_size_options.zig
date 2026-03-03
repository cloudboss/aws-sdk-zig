const SectionBasedLayoutPaperCanvasSizeOptions = @import("section_based_layout_paper_canvas_size_options.zig").SectionBasedLayoutPaperCanvasSizeOptions;

/// The options for the canvas of a section-based layout.
pub const SectionBasedLayoutCanvasSizeOptions = struct {
    /// The options for a paper canvas of a section-based layout.
    paper_canvas_size_options: ?SectionBasedLayoutPaperCanvasSizeOptions = null,

    pub const json_field_names = .{
        .paper_canvas_size_options = "PaperCanvasSizeOptions",
    };
};
