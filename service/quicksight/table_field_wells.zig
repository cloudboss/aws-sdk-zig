const TableAggregatedFieldWells = @import("table_aggregated_field_wells.zig").TableAggregatedFieldWells;
const TableUnaggregatedFieldWells = @import("table_unaggregated_field_wells.zig").TableUnaggregatedFieldWells;

/// The field wells for a table visual.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const TableFieldWells = struct {
    /// The aggregated field well for the table.
    table_aggregated_field_wells: ?TableAggregatedFieldWells,

    /// The unaggregated field well for the table.
    table_unaggregated_field_wells: ?TableUnaggregatedFieldWells,

    pub const json_field_names = .{
        .table_aggregated_field_wells = "TableAggregatedFieldWells",
        .table_unaggregated_field_wells = "TableUnaggregatedFieldWells",
    };
};
