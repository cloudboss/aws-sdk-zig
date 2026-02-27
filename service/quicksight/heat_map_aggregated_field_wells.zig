const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field wells of a heat map.
pub const HeatMapAggregatedFieldWells = struct {
    /// The columns field well of a heat map.
    columns: ?[]const DimensionField,

    /// The rows field well of a heat map.
    rows: ?[]const DimensionField,

    /// The values field well of a heat map.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .columns = "Columns",
        .rows = "Rows",
        .values = "Values",
    };
};
