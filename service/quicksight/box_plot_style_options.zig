const BoxPlotFillStyle = @import("box_plot_fill_style.zig").BoxPlotFillStyle;

/// The style options of the box plot.
pub const BoxPlotStyleOptions = struct {
    /// The fill styles (solid, transparent) of the box plot.
    fill_style: ?BoxPlotFillStyle = null,

    pub const json_field_names = .{
        .fill_style = "FillStyle",
    };
};
