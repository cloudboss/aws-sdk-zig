const Coordinate = @import("coordinate.zig").Coordinate;
const GeocoderHierarchy = @import("geocoder_hierarchy.zig").GeocoderHierarchy;

/// The preference value for the geocode preference.
pub const GeocodePreferenceValue = union(enum) {
    /// The preference coordinate for the geocode preference.
    coordinate: ?Coordinate,
    /// The preference hierarchy for the geocode preference.
    geocoder_hierarchy: ?GeocoderHierarchy,

    pub const json_field_names = .{
        .coordinate = "Coordinate",
        .geocoder_hierarchy = "GeocoderHierarchy",
    };
};
