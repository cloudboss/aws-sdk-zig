const RouteMatchingOptions = @import("route_matching_options.zig").RouteMatchingOptions;
const RouteSideOfStreetOptions = @import("route_side_of_street_options.zig").RouteSideOfStreetOptions;

/// Options related to the destination.
pub const RouteDestinationOptions = struct {
    /// The distance in meters from the destination point within which certain
    /// routing actions (such as U-turns or left turns across traffic) are
    /// restricted. This helps generate more practical routes by avoiding
    /// potentially dangerous maneuvers near the endpoint.
    avoid_actions_for_distance: i64 = 0,

    /// Avoid U-turns for calculation on highways and motorways.
    avoid_u_turns: ?bool = null,

    /// GPS Heading at the position.
    heading: f64 = 0,

    /// Options to configure matching the provided position to the road network.
    matching: ?RouteMatchingOptions = null,

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
        .side_of_street = "SideOfStreet",
        .stop_duration = "StopDuration",
    };
};
