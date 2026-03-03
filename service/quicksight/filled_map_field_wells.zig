const FilledMapAggregatedFieldWells = @import("filled_map_aggregated_field_wells.zig").FilledMapAggregatedFieldWells;

/// The field wells of a `FilledMapVisual`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const FilledMapFieldWells = struct {
    /// The aggregated field well of the filled map.
    filled_map_aggregated_field_wells: ?FilledMapAggregatedFieldWells = null,

    pub const json_field_names = .{
        .filled_map_aggregated_field_wells = "FilledMapAggregatedFieldWells",
    };
};
