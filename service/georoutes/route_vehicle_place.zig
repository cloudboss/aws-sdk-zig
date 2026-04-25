const RouteSideOfStreet = @import("route_side_of_street.zig").RouteSideOfStreet;

/// Place details corresponding to the arrival or departure.
pub const RouteVehiclePlace = struct {
    /// The name of the place.
    name: ?[]const u8 = null,

    /// Position provided in the request.
    original_position: ?[]const f64 = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    /// Options to configure matching the provided position to a side of the street.
    side_of_street: ?RouteSideOfStreet = null,

    /// Index of the waypoint in the request.
    waypoint_index: ?i32 = null,

    pub const json_field_names = .{
        .name = "Name",
        .original_position = "OriginalPosition",
        .position = "Position",
        .side_of_street = "SideOfStreet",
        .waypoint_index = "WaypointIndex",
    };
};
