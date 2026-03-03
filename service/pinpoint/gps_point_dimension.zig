const GPSCoordinates = @import("gps_coordinates.zig").GPSCoordinates;

/// Specifies GPS-based criteria for including or excluding endpoints from a
/// segment.
pub const GPSPointDimension = struct {
    /// The GPS coordinates to measure distance from.
    coordinates: GPSCoordinates,

    /// The range, in kilometers, from the GPS coordinates.
    range_in_kilometers: ?f64 = null,

    pub const json_field_names = .{
        .coordinates = "Coordinates",
        .range_in_kilometers = "RangeInKilometers",
    };
};
