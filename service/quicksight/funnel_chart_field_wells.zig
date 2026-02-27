const FunnelChartAggregatedFieldWells = @import("funnel_chart_aggregated_field_wells.zig").FunnelChartAggregatedFieldWells;

/// The field well configuration of a `FunnelChartVisual`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const FunnelChartFieldWells = struct {
    /// The field well configuration of a `FunnelChartVisual`.
    funnel_chart_aggregated_field_wells: ?FunnelChartAggregatedFieldWells,

    pub const json_field_names = .{
        .funnel_chart_aggregated_field_wells = "FunnelChartAggregatedFieldWells",
    };
};
