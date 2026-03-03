const FreeFormLayoutScreenCanvasSizeOptions = @import("free_form_layout_screen_canvas_size_options.zig").FreeFormLayoutScreenCanvasSizeOptions;

/// Configuration options for the canvas of a free-form layout.
pub const FreeFormLayoutCanvasSizeOptions = struct {
    /// The options that determine the sizing of the canvas used in a free-form
    /// layout.
    screen_canvas_size_options: ?FreeFormLayoutScreenCanvasSizeOptions = null,

    pub const json_field_names = .{
        .screen_canvas_size_options = "ScreenCanvasSizeOptions",
    };
};
