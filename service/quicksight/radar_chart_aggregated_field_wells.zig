const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field well configuration of a `RadarChartVisual`.
pub const RadarChartAggregatedFieldWells = struct {
    /// The aggregated field well categories of a radar chart.
    category: ?[]const DimensionField,

    /// The color that are assigned to the aggregated field wells of a radar chart.
    color: ?[]const DimensionField,

    /// The values that are assigned to the aggregated field wells of a radar chart.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .category = "Category",
        .color = "Color",
        .values = "Values",
    };
};
