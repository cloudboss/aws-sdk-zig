const DataLabelOptions = @import("data_label_options.zig").DataLabelOptions;
const SankeyDiagramFieldWells = @import("sankey_diagram_field_wells.zig").SankeyDiagramFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const SankeyDiagramSortConfiguration = @import("sankey_diagram_sort_configuration.zig").SankeyDiagramSortConfiguration;

/// The configuration of a sankey diagram.
pub const SankeyDiagramChartConfiguration = struct {
    /// The data label configuration of a sankey diagram.
    data_labels: ?DataLabelOptions = null,

    /// The field well configuration of a sankey diagram.
    field_wells: ?SankeyDiagramFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The sort configuration of a sankey diagram.
    sort_configuration: ?SankeyDiagramSortConfiguration = null,

    pub const json_field_names = .{
        .data_labels = "DataLabels",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .sort_configuration = "SortConfiguration",
    };
};
