const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field well for the pivot table.
pub const PivotTableAggregatedFieldWells = struct {
    /// The columns field well for a pivot table. Values are grouped by columns
    /// fields.
    columns: ?[]const DimensionField,

    /// The rows field well for a pivot table. Values are grouped by rows fields.
    rows: ?[]const DimensionField,

    /// The values field well for a pivot table. Values are aggregated based on rows
    /// and columns fields.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .columns = "Columns",
        .rows = "Rows",
        .values = "Values",
    };
};
