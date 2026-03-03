const GeospatialLineLayer = @import("geospatial_line_layer.zig").GeospatialLineLayer;
const GeospatialPointLayer = @import("geospatial_point_layer.zig").GeospatialPointLayer;
const GeospatialPolygonLayer = @import("geospatial_polygon_layer.zig").GeospatialPolygonLayer;

/// The definition properties for a geospatial layer.
pub const GeospatialLayerDefinition = struct {
    /// The definition for a line layer.
    line_layer: ?GeospatialLineLayer = null,

    /// The definition for a point layer.
    point_layer: ?GeospatialPointLayer = null,

    /// The definition for a polygon layer.
    polygon_layer: ?GeospatialPolygonLayer = null,

    pub const json_field_names = .{
        .line_layer = "LineLayer",
        .point_layer = "PointLayer",
        .polygon_layer = "PolygonLayer",
    };
};
