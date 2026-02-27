/// Position provided in the request.
pub const RouteFerryPlace = struct {
    /// The name of the place.
    name: ?[]const u8,

    /// Position provided in the request.
    original_position: ?[]const f64,

    /// Position defined as `[longitude, latitude]`.
    position: []const f64,

    /// Index of the waypoint in the request.
    waypoint_index: ?i32,

    pub const json_field_names = .{
        .name = "Name",
        .original_position = "OriginalPosition",
        .position = "Position",
        .waypoint_index = "WaypointIndex",
    };
};
