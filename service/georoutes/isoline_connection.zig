const IsolineConnectionGeometry = @import("isoline_connection_geometry.zig").IsolineConnectionGeometry;

/// Isolines may contain multiple components, if these components are connected
/// by ferry links. These components are returned as separate polygons while the
/// ferry links are returned as connections.
pub const IsolineConnection = struct {
    /// Index of the polygon corresponding to the "from" component of the
    /// connection. The polygon is available from `Isoline[].Geometries`.
    from_polygon_index: i32,

    /// The isoline geometry.
    geometry: IsolineConnectionGeometry,

    /// Index of the polygon corresponding to the "to" component of the connection.
    /// The polygon is available from `Isoline[].Geometries`.
    to_polygon_index: i32,

    pub const json_field_names = .{
        .from_polygon_index = "FromPolygonIndex",
        .geometry = "Geometry",
        .to_polygon_index = "ToPolygonIndex",
    };
};
