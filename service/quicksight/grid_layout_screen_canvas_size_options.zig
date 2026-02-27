const ResizeOption = @import("resize_option.zig").ResizeOption;

/// The options that determine the sizing of the canvas used in a grid layout.
pub const GridLayoutScreenCanvasSizeOptions = struct {
    /// The width that the view port will be optimized for when the layout renders.
    optimized_view_port_width: ?[]const u8,

    /// This value determines the layout behavior when the viewport is resized.
    ///
    /// * `FIXED`: A fixed width will be used when optimizing the layout. In
    /// the Quick Sight console, this option is called `Classic`.
    ///
    /// * `RESPONSIVE`: The width of the canvas will be responsive and
    /// optimized to the view port. In the Quick Sight console, this option is
    /// called `Tiled`.
    resize_option: ResizeOption,

    pub const json_field_names = .{
        .optimized_view_port_width = "OptimizedViewPortWidth",
        .resize_option = "ResizeOption",
    };
};
