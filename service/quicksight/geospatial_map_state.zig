const GeospatialCoordinateBounds = @import("geospatial_coordinate_bounds.zig").GeospatialCoordinateBounds;
const GeospatialMapNavigation = @import("geospatial_map_navigation.zig").GeospatialMapNavigation;

/// The map state properties for a map.
pub const GeospatialMapState = struct {
    bounds: ?GeospatialCoordinateBounds = null,

    /// Enables or disables map navigation for a map.
    map_navigation: ?GeospatialMapNavigation = null,

    pub const json_field_names = .{
        .bounds = "Bounds",
        .map_navigation = "MapNavigation",
    };
};
