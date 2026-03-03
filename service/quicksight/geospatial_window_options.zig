const GeospatialCoordinateBounds = @import("geospatial_coordinate_bounds.zig").GeospatialCoordinateBounds;
const MapZoomMode = @import("map_zoom_mode.zig").MapZoomMode;

/// The window options of the geospatial map visual.
pub const GeospatialWindowOptions = struct {
    /// The bounds options (north, south, west, east) of the geospatial window
    /// options.
    bounds: ?GeospatialCoordinateBounds = null,

    /// The map zoom modes (manual, auto) of the geospatial window options.
    map_zoom_mode: ?MapZoomMode = null,

    pub const json_field_names = .{
        .bounds = "Bounds",
        .map_zoom_mode = "MapZoomMode",
    };
};
