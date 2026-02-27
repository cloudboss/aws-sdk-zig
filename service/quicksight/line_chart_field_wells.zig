const LineChartAggregatedFieldWells = @import("line_chart_aggregated_field_wells.zig").LineChartAggregatedFieldWells;

/// The field well configuration of a line chart.
pub const LineChartFieldWells = struct {
    /// The field well configuration of a line chart.
    line_chart_aggregated_field_wells: ?LineChartAggregatedFieldWells,

    pub const json_field_names = .{
        .line_chart_aggregated_field_wells = "LineChartAggregatedFieldWells",
    };
};
