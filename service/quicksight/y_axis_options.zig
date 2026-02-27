const SingleYAxisOption = @import("single_y_axis_option.zig").SingleYAxisOption;

/// The options that are available for a single Y axis in a chart.
pub const YAxisOptions = struct {
    /// The Y axis type to be used in the chart.
    ///
    /// If you choose `PRIMARY_Y_AXIS`, the primary Y Axis is located on the
    /// leftmost vertical axis of the chart.
    y_axis: SingleYAxisOption,

    pub const json_field_names = .{
        .y_axis = "YAxis",
    };
};
