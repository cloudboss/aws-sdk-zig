const BoxPlotAggregatedFieldWells = @import("box_plot_aggregated_field_wells.zig").BoxPlotAggregatedFieldWells;

/// The field wells of a `BoxPlotVisual`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const BoxPlotFieldWells = struct {
    /// The aggregated field wells of a box plot.
    box_plot_aggregated_field_wells: ?BoxPlotAggregatedFieldWells = null,

    pub const json_field_names = .{
        .box_plot_aggregated_field_wells = "BoxPlotAggregatedFieldWells",
    };
};
