const RouteMatchingOptions = @import("route_matching_options.zig").RouteMatchingOptions;
const RouteSideOfStreetOptions = @import("route_side_of_street_options.zig").RouteSideOfStreetOptions;

/// Waypoint between the Origin and Destination.
pub const RouteWaypoint = struct {
    /// Avoids actions for the provided distance. This is typically to consider for
    /// users in moving vehicles who may not have sufficient time to make an action
    /// at an origin or a destination. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    avoid_actions_for_distance: i64 = 0,

    /// Avoid U-turns for calculation on highways and motorways. Not supported in
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    avoid_u_turns: ?bool = null,

    /// GPS Heading at the position. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    heading: f64 = 0,

    /// Options to configure matching the provided position to the road network. Not
    /// supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    matching: ?RouteMatchingOptions = null,

    /// If the waypoint should not be treated as a stop. If yes, the waypoint is
    /// passed through and doesn't split the route into different legs. Not
    /// supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    pass_through: ?bool = null,

    /// Position in World Geodetic System (WGS 84) format: [longitude, latitude].
    position: []const f64,

    /// Options to configure matching the provided position to a side of the street.
    /// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    side_of_street: ?RouteSideOfStreetOptions = null,

    /// Duration of the stop. Not supported in `ap-southeast-1` and `ap-southeast-5`
    /// regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
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
