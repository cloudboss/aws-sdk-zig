/// The options that determine the sizing of the canvas used in a free-form
/// layout.
pub const FreeFormLayoutScreenCanvasSizeOptions = struct {
    /// The width that the view port will be optimized for when the layout renders.
    optimized_view_port_width: []const u8,

    pub const json_field_names = .{
        .optimized_view_port_width = "OptimizedViewPortWidth",
    };
};
