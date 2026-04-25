/// The optimized waypoint.
pub const WaypointOptimizationOptimizedWaypoint = struct {
    /// Estimated time of arrival at the destination.
    ///
    /// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    arrival_time: ?[]const u8 = null,

    /// Index of the cluster the waypoint is associated with. The index is included
    /// in the response only if clustering was performed while processing the
    /// request.
    cluster_index: ?i32 = null,

    /// Estimated time of departure from the origin.
    ///
    /// Time format:`YYYY-MM-DDThh:mm:ss.sssZ | YYYY-MM-DDThh:mm:ss.sss+hh:mm`
    ///
    /// Examples:
    ///
    /// `2020-04-22T17:57:24Z`
    ///
    /// `2020-04-22T17:57:24+02:00`
    departure_time: []const u8,

    /// The waypoint Id.
    id: []const u8,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    pub const json_field_names = .{
        .arrival_time = "ArrivalTime",
        .cluster_index = "ClusterIndex",
        .departure_time = "DepartureTime",
        .id = "Id",
        .position = "Position",
    };
};
