const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field well for a box plot.
pub const BoxPlotAggregatedFieldWells = struct {
    /// The group by field well of a box plot chart. Values are grouped based on
    /// group by fields.
    group_by: ?[]const DimensionField,

    /// The value field well of a box plot chart. Values are aggregated based on
    /// group by fields.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .group_by = "GroupBy",
        .values = "Values",
    };
};
