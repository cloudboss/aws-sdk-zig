const RadarChartAggregatedFieldWells = @import("radar_chart_aggregated_field_wells.zig").RadarChartAggregatedFieldWells;

/// The field wells of a radar chart visual.
pub const RadarChartFieldWells = struct {
    /// The aggregated field wells of a radar chart visual.
    radar_chart_aggregated_field_wells: ?RadarChartAggregatedFieldWells = null,

    pub const json_field_names = .{
        .radar_chart_aggregated_field_wells = "RadarChartAggregatedFieldWells",
    };
};
