const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The field well configuration of a sankey diagram.
pub const SankeyDiagramAggregatedFieldWells = struct {
    /// The destination field wells of a sankey diagram.
    destination: ?[]const DimensionField,

    /// The source field wells of a sankey diagram.
    source: ?[]const DimensionField,

    /// The weight field wells of a sankey diagram.
    weight: ?[]const MeasureField,

    pub const json_field_names = .{
        .destination = "Destination",
        .source = "Source",
        .weight = "Weight",
    };
};
