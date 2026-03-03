const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The unaggregated field wells of a scatter plot.
pub const ScatterPlotUnaggregatedFieldWells = struct {
    /// The category field well of a scatter plot.
    category: ?[]const DimensionField = null,

    /// The label field well of a scatter plot.
    label: ?[]const DimensionField = null,

    /// The size field well of a scatter plot.
    size: ?[]const MeasureField = null,

    /// The x-axis field well of a scatter plot.
    ///
    /// The x-axis is a dimension field and cannot be aggregated.
    x_axis: ?[]const DimensionField = null,

    /// The y-axis field well of a scatter plot.
    ///
    /// The y-axis is a dimension field and cannot be aggregated.
    y_axis: ?[]const DimensionField = null,

    pub const json_field_names = .{
        .category = "Category",
        .label = "Label",
        .size = "Size",
        .x_axis = "XAxis",
        .y_axis = "YAxis",
    };
};
