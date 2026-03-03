const Visibility = @import("visibility.zig").Visibility;
const BoxPlotStyleOptions = @import("box_plot_style_options.zig").BoxPlotStyleOptions;

/// The options of a box plot visual.
pub const BoxPlotOptions = struct {
    /// Determines the visibility of all data points of the box plot.
    all_data_points_visibility: ?Visibility = null,

    /// Determines the visibility of the outlier in a box plot.
    outlier_visibility: ?Visibility = null,

    /// The style options of the box plot.
    style_options: ?BoxPlotStyleOptions = null,

    pub const json_field_names = .{
        .all_data_points_visibility = "AllDataPointsVisibility",
        .outlier_visibility = "OutlierVisibility",
        .style_options = "StyleOptions",
    };
};
