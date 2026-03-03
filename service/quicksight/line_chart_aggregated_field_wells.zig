const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The field well configuration of a line chart.
pub const LineChartAggregatedFieldWells = struct {
    /// The category field wells of a line chart. Values are grouped by category
    /// fields.
    category: ?[]const DimensionField = null,

    /// The color field wells of a line chart. Values are grouped by category
    /// fields.
    colors: ?[]const DimensionField = null,

    /// The small multiples field well of a line chart.
    small_multiples: ?[]const DimensionField = null,

    /// The value field wells of a line chart. Values are aggregated based on
    /// categories.
    values: ?[]const MeasureField = null,

    pub const json_field_names = .{
        .category = "Category",
        .colors = "Colors",
        .small_multiples = "SmallMultiples",
        .values = "Values",
    };
};
