const RouteMatchingOptions = @import("route_matching_options.zig").RouteMatchingOptions;
const RouteSideOfStreetOptions = @import("route_side_of_street_options.zig").RouteSideOfStreetOptions;

/// Waypoint between the Origin and Destination.
pub const RouteWaypoint = struct {
    /// Avoids actions for the provided distance. This is typically to consider for
    /// users in moving vehicles who may not have sufficient time to make an action
    /// at an origin or a destination.
    avoid_actions_for_distance: i64 = 0,

    /// Avoid U-turns for calculation on highways and motorways.
    avoid_u_turns: ?bool = null,

    /// GPS Heading at the position.
    heading: f64 = 0,

    /// Options to configure matching the provided position to the road network.
    matching: ?RouteMatchingOptions = null,

    /// If the waypoint should not be treated as a stop. If yes, the waypoint is
    /// passed through and doesn't split the route into different legs.
    pass_through: ?bool = null,

    /// Position defined as `[longitude, latitude]`.
    position: []const f64,

    /// Options to configure matching the provided position to a side of the street.
    side_of_street: ?RouteSideOfStreetOptions = null,

    /// Duration of the stop.
    ///
    /// **Unit**: `seconds`
    stop_duration: i64 = 0,

    pub const json_field_names = .{
        .avoid_actions_for_distance = "AvoidActionsForDistance",
        .avoid_u_turns = "AvoidUTurns",
        .heading = "Heading",
        .matching = "Matching",
        .pass_through = "PassThrough",
        .position = "Position",
        .side_of_street = "SideOfStreet",
        .stop_duration = "StopDuration",
    };
};
