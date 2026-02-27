const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field well of a scatter plot.
pub const ScatterPlotCategoricallyAggregatedFieldWells = struct {
    /// The category field well of a scatter plot.
    category: ?[]const DimensionField,

    /// The label field well of a scatter plot.
    label: ?[]const DimensionField,

    /// The size field well of a scatter plot.
    size: ?[]const MeasureField,

    /// The x-axis field well of a scatter plot.
    ///
    /// The x-axis is aggregated by category.
    x_axis: ?[]const MeasureField,

    /// The y-axis field well of a scatter plot.
    ///
    /// The y-axis is aggregated by category.
    y_axis: ?[]const MeasureField,

    pub const json_field_names = .{
        .category = "Category",
        .label = "Label",
        .size = "Size",
        .x_axis = "XAxis",
        .y_axis = "YAxis",
    };
};
