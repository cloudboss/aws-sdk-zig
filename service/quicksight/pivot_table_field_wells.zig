const PivotTableAggregatedFieldWells = @import("pivot_table_aggregated_field_wells.zig").PivotTableAggregatedFieldWells;

/// The field wells for a pivot table visual.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const PivotTableFieldWells = struct {
    /// The aggregated field well for the pivot table.
    pivot_table_aggregated_field_wells: ?PivotTableAggregatedFieldWells = null,

    pub const json_field_names = .{
        .pivot_table_aggregated_field_wells = "PivotTableAggregatedFieldWells",
    };
};
