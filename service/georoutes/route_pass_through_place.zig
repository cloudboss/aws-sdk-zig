/// The place where the waypoint is passed through and not treated as a stop.
pub const RoutePassThroughPlace = struct {
    /// Position provided in the request.
    original_position: ?[]const f64 = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    /// Index of the waypoint in the request.
    waypoint_index: ?i32 = null,

    pub const json_field_names = .{
        .original_position = "OriginalPosition",
        .position = "Position",
        .waypoint_index = "WaypointIndex",
    };
};
