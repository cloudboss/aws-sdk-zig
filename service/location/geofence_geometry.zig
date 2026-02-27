const Circle = @import("circle.zig").Circle;

/// Contains the geofence geometry details.
///
/// A geofence geometry can be a circle, a polygon, or a multipolygon. `Polygon`
/// and `MultiPolygon` geometries can be defined using their respective
/// parameters, or encoded in Geobuf format using the `Geobuf` parameter.
/// Including multiple geometry types in the same request will return a
/// validation error.
///
/// Amazon Location doesn't currently support polygons that cross the
/// antimeridian.
pub const GeofenceGeometry = struct {
    /// A circle on the earth, as defined by a center point and a radius.
    circle: ?Circle,

    /// Geobuf is a compact binary encoding for geographic data that provides
    /// lossless compression of GeoJSON polygons. The Geobuf must be Base64-encoded.
    ///
    /// This parameter can contain a Geobuf-encoded GeoJSON geometry object of type
    /// `Polygon` *OR* `MultiPolygon`. For more information and specific
    /// configuration requirements for these object types, see
    /// [Polygon](https://docs.aws.amazon.com/location/latest/APIReference/API_WaypointGeofencing_GeofenceGeometry.html#location-Type-WaypointGeofencing_GeofenceGeometry-Polygon) and [MultiPolygon](https://docs.aws.amazon.com/location/latest/APIReference/API_WaypointGeofencing_GeofenceGeometry.html#location-Type-WaypointGeofencing_GeofenceGeometry-MultiPolygon).
    ///
    /// The following limitations apply specifically to geometries defined using the
    /// `Geobuf` parameter, and supercede the corresponding limitations of the
    /// `Polygon` and `MultiPolygon` parameters:
    ///
    /// * A `Polygon` in `Geobuf` format can have up to 25,000 rings and up to
    ///   100,000 total vertices, including all vertices from all component rings.
    /// * A `MultiPolygon` in `Geobuf` format can contain up to 10,000 `Polygons`
    ///   and up to 100,000 total vertices, including all vertices from all
    ///   component `Polygons`.
    geobuf: ?[]const u8,

    /// A `MultiPolygon` is a list of up to 250 `Polygon` elements which represent
    /// the shape of a geofence. The `Polygon` components of a `MultiPolygon`
    /// geometry can define separate geographical areas that are considered part of
    /// the same geofence, perimeters of larger exterior areas with smaller interior
    /// spaces that are excluded from the geofence, or some combination of these use
    /// cases to form complex geofence boundaries.
    ///
    /// For more information and specific configuration requirements for the
    /// `Polygon` components that form a `MultiPolygon`, see
    /// [Polygon](https://docs.aws.amazon.com/location/latest/APIReference/API_WaypointGeofencing_GeofenceGeometry.html#location-Type-WaypointGeofencing_GeofenceGeometry-Polygon).
    ///
    /// The following additional requirements and limitations apply to geometries
    /// defined using the `MultiPolygon` parameter:
    ///
    /// * The entire `MultiPolygon` must consist of no more than 1,000 vertices,
    ///   including all vertices from all component `Polygons`.
    /// * Each edge of a component `Polygon` must intersect no more than 5 edges
    ///   from other `Polygons`. Parallel edges that are shared but do not cross are
    ///   not counted toward this limit.
    /// * The total number of intersecting edges of component `Polygons` must be no
    ///   more than 100,000. Parallel edges that are shared but do not cross are not
    ///   counted toward this limit.
    multi_polygon: ?[]const []const []const []const f64,

    /// A `Polygon` is a list of up to 250 linear rings which represent the shape of
    /// a geofence. This list *must* include 1 exterior ring (representing the outer
    /// perimeter of the geofence), and can optionally include up to 249 interior
    /// rings (representing polygonal spaces within the perimeter, which are
    /// excluded from the geofence area).
    ///
    /// A linear ring is an array of 4 or more vertices, where the first and last
    /// vertex are the same (to form a closed boundary). Each vertex is a
    /// 2-dimensional point represented as an array of doubles of length 2:
    /// `[longitude, latitude]`.
    ///
    /// Each linear ring is represented as an array of arrays of doubles
    /// (`[[longitude, latitude], [longitude, latitude], ...]`). The vertices for
    /// the exterior ring must be listed in *counter-clockwise* sequence. Vertices
    /// for all interior rings must be listed in *clockwise* sequence.
    ///
    /// The list of linear rings that describe the entire `Polygon` is represented
    /// as an array of arrays of arrays of doubles (`[[[longitude, latitude],
    /// [longitude, latitude], ...], [[longitude, latitude], [longitude, latitude],
    /// ...], ...]`). The exterior ring must be listed first, before any interior
    /// rings.
    ///
    /// The following additional requirements and limitations apply to geometries
    /// defined using the `Polygon` parameter:
    ///
    /// * The entire `Polygon` must consist of no more than 1,000 vertices,
    ///   including all vertices from the exterior ring and all interior rings.
    /// * Rings must not touch or cross each other.
    /// * All interior rings must be fully contained within the exterior ring.
    /// * Interior rings must not contain other interior rings.
    /// * No ring is permitted to intersect itself.
    polygon: ?[]const []const []const f64,

    pub const json_field_names = .{
        .circle = "Circle",
        .geobuf = "Geobuf",
        .multi_polygon = "MultiPolygon",
        .polygon = "Polygon",
    };
};
