const AreaOfInterestGeometry = @import("area_of_interest_geometry.zig").AreaOfInterestGeometry;

/// The geographic extent of the Earth Observation job.
pub const AreaOfInterest = union(enum) {
    /// A GeoJSON object representing the geographic extent in the coordinate space.
    area_of_interest_geometry: ?AreaOfInterestGeometry,

    pub const json_field_names = .{
        .area_of_interest_geometry = "AreaOfInterestGeometry",
    };
};
