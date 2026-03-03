const PieChartAggregatedFieldWells = @import("pie_chart_aggregated_field_wells.zig").PieChartAggregatedFieldWells;

/// The field well configuration of a pie chart.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const PieChartFieldWells = struct {
    /// The field well configuration of a pie chart.
    pie_chart_aggregated_field_wells: ?PieChartAggregatedFieldWells = null,

    pub const json_field_names = .{
        .pie_chart_aggregated_field_wells = "PieChartAggregatedFieldWells",
    };
};
