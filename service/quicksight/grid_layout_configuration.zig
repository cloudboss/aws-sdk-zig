const GridLayoutCanvasSizeOptions = @import("grid_layout_canvas_size_options.zig").GridLayoutCanvasSizeOptions;
const GridLayoutElement = @import("grid_layout_element.zig").GridLayoutElement;

/// The configuration for a grid layout. Also called a tiled layout.
///
/// Visuals snap to a grid with standard spacing and alignment. Dashboards are
/// displayed as designed, with options to fit to screen or view at actual size.
pub const GridLayoutConfiguration = struct {
    canvas_size_options: ?GridLayoutCanvasSizeOptions = null,

    /// The elements that are included in a grid layout.
    elements: []const GridLayoutElement,

    pub const json_field_names = .{
        .canvas_size_options = "CanvasSizeOptions",
        .elements = "Elements",
    };
};
