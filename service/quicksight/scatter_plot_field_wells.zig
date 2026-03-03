const ScatterPlotCategoricallyAggregatedFieldWells = @import("scatter_plot_categorically_aggregated_field_wells.zig").ScatterPlotCategoricallyAggregatedFieldWells;
const ScatterPlotUnaggregatedFieldWells = @import("scatter_plot_unaggregated_field_wells.zig").ScatterPlotUnaggregatedFieldWells;

/// The field well configuration of a scatter plot.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const ScatterPlotFieldWells = struct {
    /// The aggregated field wells of a scatter plot. The x and y-axes of scatter
    /// plots with aggregated field wells are aggregated by category, label, or
    /// both.
    scatter_plot_categorically_aggregated_field_wells: ?ScatterPlotCategoricallyAggregatedFieldWells = null,

    /// The unaggregated field wells of a scatter plot. The x and y-axes of these
    /// scatter plots are
    /// unaggregated.
    scatter_plot_unaggregated_field_wells: ?ScatterPlotUnaggregatedFieldWells = null,

    pub const json_field_names = .{
        .scatter_plot_categorically_aggregated_field_wells = "ScatterPlotCategoricallyAggregatedFieldWells",
        .scatter_plot_unaggregated_field_wells = "ScatterPlotUnaggregatedFieldWells",
    };
};
