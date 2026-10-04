/// `AutoCircle` requests the route matrix service to define a `Circle` boundary
/// that best attempts to include most waypoints (`Origins` and `Destinations`)
/// using the `AutoCircle` settings. Any waypoints outside of the auto-defined
/// `Circle` boundary will be considered out of the routing boundary, which
/// results in a route matrix entry error.
///
/// `AutoCircle` is only used in the request to configure a `Circle` for the
/// route calculation. The derived `Circle` will also be provided in the
/// response.
pub const RouteMatrixAutoCircle = struct {
    /// The minimal distance, in meters, between any waypoint and the perimeter of
    /// the circle auto-defined for the boundary. Some margin is usually recommended
    /// so that the routing has enough leeway to travel from one waypoint to another
    /// optimally without conflicting with the routing boundary.
    ///
    /// The total of `MaxRadius` and `Margin` must be less than or equal to 200,000
    /// meters.
    margin: i64 = 0,

    /// The maximum radius, in meters, that the auto-defined `Circle` boundary
    /// should have, before the `Margin` distance is added to the circle.
    ///
    /// The total of `MaxRadius` and `Margin` must be less than or equal to 200,000
    /// meters.
    max_radius: i64 = 0,

    pub const json_field_names = .{
        .margin = "Margin",
        .max_radius = "MaxRadius",
    };
};
