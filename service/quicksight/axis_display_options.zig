const Visibility = @import("visibility.zig").Visibility;
const AxisDataOptions = @import("axis_data_options.zig").AxisDataOptions;
const ScrollBarOptions = @import("scroll_bar_options.zig").ScrollBarOptions;
const AxisTickLabelOptions = @import("axis_tick_label_options.zig").AxisTickLabelOptions;

/// The display options for the axis label.
pub const AxisDisplayOptions = struct {
    /// Determines whether or not the axis line is visible.
    axis_line_visibility: ?Visibility,

    /// The offset value that determines the starting placement of the axis within a
    /// visual's bounds.
    axis_offset: ?[]const u8,

    /// The data options for an axis.
    data_options: ?AxisDataOptions,

    /// Determines whether or not the grid line is visible.
    grid_line_visibility: ?Visibility,

    /// The scroll bar options for an axis.
    scrollbar_options: ?ScrollBarOptions,

    /// The tick label options of an axis.
    tick_label_options: ?AxisTickLabelOptions,

    pub const json_field_names = .{
        .axis_line_visibility = "AxisLineVisibility",
        .axis_offset = "AxisOffset",
        .data_options = "DataOptions",
        .grid_line_visibility = "GridLineVisibility",
        .scrollbar_options = "ScrollbarOptions",
        .tick_label_options = "TickLabelOptions",
    };
};
