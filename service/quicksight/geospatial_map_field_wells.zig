const GeospatialMapAggregatedFieldWells = @import("geospatial_map_aggregated_field_wells.zig").GeospatialMapAggregatedFieldWells;

/// The field wells of a `GeospatialMapVisual`.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const GeospatialMapFieldWells = struct {
    /// The aggregated field well for a geospatial map.
    geospatial_map_aggregated_field_wells: ?GeospatialMapAggregatedFieldWells,

    pub const json_field_names = .{
        .geospatial_map_aggregated_field_wells = "GeospatialMapAggregatedFieldWells",
    };
};
