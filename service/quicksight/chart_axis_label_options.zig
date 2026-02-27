const AxisLabelOptions = @import("axis_label_options.zig").AxisLabelOptions;
const Visibility = @import("visibility.zig").Visibility;

/// The label options for an axis on a chart.
pub const ChartAxisLabelOptions = struct {
    /// The label options for a chart axis.
    axis_label_options: ?[]const AxisLabelOptions,

    /// The visibility configuration of the sort icon on a chart's axis label.
    sort_icon_visibility: ?Visibility,

    /// The visibility of an axis label on a chart. Choose one of the following
    /// options:
    ///
    /// * `VISIBLE`: Shows the axis.
    ///
    /// * `HIDDEN`: Hides the axis.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .axis_label_options = "AxisLabelOptions",
        .sort_icon_visibility = "SortIconVisibility",
        .visibility = "Visibility",
    };
};
