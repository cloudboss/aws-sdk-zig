const IsolineConnectionGeometry = @import("isoline_connection_geometry.zig").IsolineConnectionGeometry;

/// Represents a segment of the transportation network that connects separate
/// parts of a reachable area. These connections show how discontinuous areas
/// are linked, such as by ferry routes or bridges crossing unroutable terrain.
pub const IsolineConnection = struct {
    /// The index of the starting polygon in the isoline's `Geometries` list.
    from_polygon_index: i32,

    /// The shape of the connection, representing the actual path through the
    /// transportation network that links the polygons.
    geometry: IsolineConnectionGeometry,

    /// The index of the ending polygon in the isoline's `Geometries` list.
    to_polygon_index: i32,

    pub const json_field_names = .{
        .from_polygon_index = "FromPolygonIndex",
        .geometry = "Geometry",
        .to_polygon_index = "ToPolygonIndex",
    };
};
