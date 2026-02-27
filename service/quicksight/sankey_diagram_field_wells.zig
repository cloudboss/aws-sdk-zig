const SankeyDiagramAggregatedFieldWells = @import("sankey_diagram_aggregated_field_wells.zig").SankeyDiagramAggregatedFieldWells;

/// The field well configuration of a sankey diagram.
pub const SankeyDiagramFieldWells = struct {
    /// The field well configuration of a sankey diagram.
    sankey_diagram_aggregated_field_wells: ?SankeyDiagramAggregatedFieldWells,

    pub const json_field_names = .{
        .sankey_diagram_aggregated_field_wells = "SankeyDiagramAggregatedFieldWells",
    };
};
