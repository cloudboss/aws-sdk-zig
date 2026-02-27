const FreeFormLayoutCanvasSizeOptions = @import("free_form_layout_canvas_size_options.zig").FreeFormLayoutCanvasSizeOptions;

/// The options that determine the default settings of a free-form layout
/// configuration.
pub const DefaultFreeFormLayoutConfiguration = struct {
    /// Determines the screen canvas size options for a free-form layout.
    canvas_size_options: FreeFormLayoutCanvasSizeOptions,

    pub const json_field_names = .{
        .canvas_size_options = "CanvasSizeOptions",
    };
};
