const Spacing = @import("spacing.zig").Spacing;
const PaperOrientation = @import("paper_orientation.zig").PaperOrientation;
const PaperSize = @import("paper_size.zig").PaperSize;

/// The options for a paper canvas of a section-based layout.
pub const SectionBasedLayoutPaperCanvasSizeOptions = struct {
    /// Defines the spacing between the canvas content and the top, bottom, left,
    /// and right edges.
    paper_margin: ?Spacing = null,

    /// The paper orientation that
    /// is used to define canvas dimensions. Choose one of the following
    /// options:
    ///
    /// * PORTRAIT
    ///
    /// * LANDSCAPE
    paper_orientation: ?PaperOrientation = null,

    /// The paper size that is used to define canvas dimensions.
    paper_size: ?PaperSize = null,

    pub const json_field_names = .{
        .paper_margin = "PaperMargin",
        .paper_orientation = "PaperOrientation",
        .paper_size = "PaperSize",
    };
};
