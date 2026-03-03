const WaterfallChartAggregatedFieldWells = @import("waterfall_chart_aggregated_field_wells.zig").WaterfallChartAggregatedFieldWells;

/// The field well configuration of a waterfall visual.
pub const WaterfallChartFieldWells = struct {
    /// The field well configuration of a waterfall visual.
    waterfall_chart_aggregated_field_wells: ?WaterfallChartAggregatedFieldWells = null,

    pub const json_field_names = .{
        .waterfall_chart_aggregated_field_wells = "WaterfallChartAggregatedFieldWells",
    };
};
