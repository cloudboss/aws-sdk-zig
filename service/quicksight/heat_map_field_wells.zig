const HeatMapAggregatedFieldWells = @import("heat_map_aggregated_field_wells.zig").HeatMapAggregatedFieldWells;

/// The field well configuration of a heat map.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const HeatMapFieldWells = struct {
    /// The aggregated field wells of a heat map.
    heat_map_aggregated_field_wells: ?HeatMapAggregatedFieldWells,

    pub const json_field_names = .{
        .heat_map_aggregated_field_wells = "HeatMapAggregatedFieldWells",
    };
};
