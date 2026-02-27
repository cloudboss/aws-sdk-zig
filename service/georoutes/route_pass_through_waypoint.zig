const RoutePassThroughPlace = @import("route_pass_through_place.zig").RoutePassThroughPlace;

/// If the waypoint should be treated as a stop. If yes, the route is split up
/// into different legs around the stop.
pub const RoutePassThroughWaypoint = struct {
    /// Offset in the leg geometry corresponding to the start of this step.
    geometry_offset: ?i32,

    /// The place details.
    place: RoutePassThroughPlace,

    pub const json_field_names = .{
        .geometry_offset = "GeometryOffset",
        .place = "Place",
    };
};
