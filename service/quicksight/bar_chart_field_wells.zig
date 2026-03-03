const BarChartAggregatedFieldWells = @import("bar_chart_aggregated_field_wells.zig").BarChartAggregatedFieldWells;

/// The field wells of a `BarChartVisual`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const BarChartFieldWells = struct {
    /// The aggregated field wells of a bar chart.
    bar_chart_aggregated_field_wells: ?BarChartAggregatedFieldWells = null,

    pub const json_field_names = .{
        .bar_chart_aggregated_field_wells = "BarChartAggregatedFieldWells",
    };
};
