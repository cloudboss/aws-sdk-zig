const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The field well configuration of a `FunnelChartVisual`.
pub const FunnelChartAggregatedFieldWells = struct {
    /// The category field wells of a funnel chart. Values are grouped by category
    /// fields.
    category: ?[]const DimensionField,

    /// The value field wells of a funnel chart. Values are aggregated based on
    /// categories.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .category = "Category",
        .values = "Values",
    };
};
