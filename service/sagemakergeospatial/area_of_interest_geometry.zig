const MultiPolygonGeometryInput = @import("multi_polygon_geometry_input.zig").MultiPolygonGeometryInput;
const PolygonGeometryInput = @import("polygon_geometry_input.zig").PolygonGeometryInput;

/// A GeoJSON object representing the geographic extent in the coordinate space.
pub const AreaOfInterestGeometry = union(enum) {
    /// The structure representing the MultiPolygon Geometry.
    multi_polygon_geometry: ?MultiPolygonGeometryInput,
    /// The structure representing Polygon Geometry.
    polygon_geometry: ?PolygonGeometryInput,

    pub const json_field_names = .{
        .multi_polygon_geometry = "MultiPolygonGeometry",
        .polygon_geometry = "PolygonGeometry",
    };
};
