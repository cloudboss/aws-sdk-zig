const GridLayoutScreenCanvasSizeOptions = @import("grid_layout_screen_canvas_size_options.zig").GridLayoutScreenCanvasSizeOptions;

/// Configuration options for the canvas of a grid layout.
pub const GridLayoutCanvasSizeOptions = struct {
    /// The options that determine the sizing of the canvas used in a grid layout.
    screen_canvas_size_options: ?GridLayoutScreenCanvasSizeOptions = null,

    pub const json_field_names = .{
        .screen_canvas_size_options = "ScreenCanvasSizeOptions",
    };
};
