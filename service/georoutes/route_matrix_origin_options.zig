const RouteMatrixMatchingOptions = @import("route_matrix_matching_options.zig").RouteMatrixMatchingOptions;
const RouteMatrixSideOfStreetOptions = @import("route_matrix_side_of_street_options.zig").RouteMatrixSideOfStreetOptions;

/// Origin related options.
pub const RouteMatrixOriginOptions = struct {
    /// Avoids actions for the provided distance. This is typically to consider for
    /// users in moving vehicles who may not have sufficient time to make an action
    /// at an origin or a destination.
    avoid_actions_for_distance: i64 = 0,

    /// GPS Heading at the position.
    heading: f64 = 0,

    /// Options to configure matching the provided position to the road network.
    matching: ?RouteMatrixMatchingOptions = null,

    /// Options to configure matching the provided position to a side of the street.
    side_of_street: ?RouteMatrixSideOfStreetOptions = null,

    pub const json_field_names = .{
        .avoid_actions_for_distance = "AvoidActionsForDistance",
        .heading = "Heading",
        .matching = "Matching",
        .side_of_street = "SideOfStreet",
    };
};
