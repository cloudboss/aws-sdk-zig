const MeasureField = @import("measure_field.zig").MeasureField;
const DimensionField = @import("dimension_field.zig").DimensionField;

/// The aggregated field wells of a combo chart.
pub const ComboChartAggregatedFieldWells = struct {
    /// The aggregated `BarValues` field well of a combo chart.
    bar_values: ?[]const MeasureField,

    /// The aggregated category field wells of a combo chart.
    category: ?[]const DimensionField,

    /// The aggregated colors field well of a combo chart.
    colors: ?[]const DimensionField,

    /// The aggregated `LineValues` field well of a combo chart.
    line_values: ?[]const MeasureField,

    pub const json_field_names = .{
        .bar_values = "BarValues",
        .category = "Category",
        .colors = "Colors",
        .line_values = "LineValues",
    };
};
