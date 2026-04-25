const IsolineConnection = @import("isoline_connection.zig").IsolineConnection;
const IsolineShapeGeometry = @import("isoline_shape_geometry.zig").IsolineShapeGeometry;

/// Represents a single reachable area calculated for a specific threshold.
pub const Isoline = struct {
    /// Lines connecting separate parts of the reachable area that can be reached
    /// within the same threshold. These occur when areas are reachable but not
    /// contiguous, such as when separated by water or unroutable areas. When
    /// present, these lines represent actual transportation network segments (such
    /// as ferry routes or bridges) that connect the separated areas.
    connections: []const IsolineConnection,

    /// The travel distance in meters used to calculate this isoline, if
    /// distance-based thresholds were specified in the request.
    distance_threshold: i64 = 0,

    /// The shapes that define the reachable area, provided in the requested
    /// geometry format.
    geometries: []const IsolineShapeGeometry,

    /// The travel time in seconds used to calculate this isoline, if time-based
    /// thresholds were specified in the request.
    time_threshold: i64 = 0,

    pub const json_field_names = .{
        .connections = "Connections",
        .distance_threshold = "DistanceThreshold",
        .geometries = "Geometries",
        .time_threshold = "TimeThreshold",
    };
};
