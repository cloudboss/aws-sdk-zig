const RouteMatchingOptions = @import("route_matching_options.zig").RouteMatchingOptions;
const RouteSideOfStreetOptions = @import("route_side_of_street_options.zig").RouteSideOfStreetOptions;

/// Origin related options.
pub const RouteOriginOptions = struct {
    /// Avoids actions for the provided distance. This is typically to consider for
    /// users in moving vehicles who may not have sufficient time to make an action
    /// at an origin or a destination.
    avoid_actions_for_distance: i64 = 0,

    /// Avoid U-turns for calculation on highways and motorways.
    avoid_u_turns: ?bool,

    /// GPS Heading at the position.
    heading: f64 = 0,

    /// Options to configure matching the provided position to the road network.
    matching: ?RouteMatchingOptions,

    /// Options to configure matching the provided position to a side of the street.
    side_of_street: ?RouteSideOfStreetOptions,

    pub const json_field_names = .{
        .avoid_actions_for_distance = "AvoidActionsForDistance",
        .avoid_u_turns = "AvoidUTurns",
        .heading = "Heading",
        .matching = "Matching",
        .side_of_street = "SideOfStreet",
    };
};
