const ComboChartAggregatedFieldWells = @import("combo_chart_aggregated_field_wells.zig").ComboChartAggregatedFieldWells;

/// The field wells of the visual.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const ComboChartFieldWells = struct {
    /// The aggregated field wells of a combo chart. Combo charts only have
    /// aggregated field wells. Columns in a combo chart are aggregated by category.
    combo_chart_aggregated_field_wells: ?ComboChartAggregatedFieldWells,

    pub const json_field_names = .{
        .combo_chart_aggregated_field_wells = "ComboChartAggregatedFieldWells",
    };
};
