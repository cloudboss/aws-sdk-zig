const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field wells of a bar chart.
pub const BarChartAggregatedFieldWells = struct {
    /// The category (y-axis) field well of a bar chart.
    category: ?[]const DimensionField = null,

    /// The color (group/color) field well of a bar chart.
    colors: ?[]const DimensionField = null,

    /// The small multiples field well of a bar chart.
    small_multiples: ?[]const DimensionField = null,

    /// The value field wells of a bar chart. Values are aggregated by
    /// category.
    values: ?[]const MeasureField = null,

    pub const json_field_names = .{
        .category = "Category",
        .colors = "Colors",
        .small_multiples = "SmallMultiples",
        .values = "Values",
    };
};
