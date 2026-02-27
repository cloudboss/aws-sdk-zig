const IsolineConnection = @import("isoline_connection.zig").IsolineConnection;
const IsolineShapeGeometry = @import("isoline_shape_geometry.zig").IsolineShapeGeometry;

/// Calculated isolines and associated properties.
pub const Isoline = struct {
    /// Isolines may contain multiple components, if these components are connected
    /// by ferry links. These components are returned as separate polygons while the
    /// ferry links are returned as connections.
    connections: []const IsolineConnection,

    /// Distance threshold corresponding to the calculated Isoline.
    distance_threshold: i64 = 0,

    /// Geometries for the Calculated isolines.
    geometries: []const IsolineShapeGeometry,

    /// Time threshold corresponding to the calculated isoline.
    time_threshold: i64 = 0,

    pub const json_field_names = .{
        .connections = "Connections",
        .distance_threshold = "DistanceThreshold",
        .geometries = "Geometries",
        .time_threshold = "TimeThreshold",
    };
};
