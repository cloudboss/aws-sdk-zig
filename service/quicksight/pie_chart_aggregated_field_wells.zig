const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The field well configuration of a pie chart.
pub const PieChartAggregatedFieldWells = struct {
    /// The category (group/color) field wells of a pie chart.
    category: ?[]const DimensionField = null,

    /// The small multiples field well of a pie chart.
    small_multiples: ?[]const DimensionField = null,

    /// The value field wells of a pie chart. Values are aggregated based on
    /// categories.
    values: ?[]const MeasureField = null,

    pub const json_field_names = .{
        .category = "Category",
        .small_multiples = "SmallMultiples",
        .values = "Values",
    };
};
