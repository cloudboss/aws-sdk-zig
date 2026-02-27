const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field well for the table.
pub const TableAggregatedFieldWells = struct {
    /// The group by field well for a pivot table. Values are grouped by group by
    /// fields.
    group_by: ?[]const DimensionField,

    /// The values field well for a pivot table. Values are aggregated based on
    /// group by fields.
    values: ?[]const MeasureField,

    pub const json_field_names = .{
        .group_by = "GroupBy",
        .values = "Values",
    };
};
