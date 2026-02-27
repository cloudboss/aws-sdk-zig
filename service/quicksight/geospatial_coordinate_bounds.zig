/// The bound
/// options (north, south, west, east) of the geospatial window options.
pub const GeospatialCoordinateBounds = struct {
    /// The longitude of the east bound of the geospatial coordinate bounds.
    east: f64,

    /// The latitude of the north bound of the geospatial coordinate bounds.
    north: f64,

    /// The latitude of the south bound of the geospatial coordinate bounds.
    south: f64,

    /// The longitude of the west bound of the geospatial coordinate bounds.
    west: f64,

    pub const json_field_names = .{
        .east = "East",
        .north = "North",
        .south = "South",
        .west = "West",
    };
};
