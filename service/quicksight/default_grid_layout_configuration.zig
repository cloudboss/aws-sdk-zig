const GridLayoutCanvasSizeOptions = @import("grid_layout_canvas_size_options.zig").GridLayoutCanvasSizeOptions;

/// The options that determine the default settings for a grid layout
/// configuration.
pub const DefaultGridLayoutConfiguration = struct {
    /// Determines the screen canvas size options for a grid layout.
    canvas_size_options: GridLayoutCanvasSizeOptions,

    pub const json_field_names = .{
        .canvas_size_options = "CanvasSizeOptions",
    };
};
