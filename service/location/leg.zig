const LegGeometry = @import("leg_geometry.zig").LegGeometry;
const Step = @import("step.zig").Step;

/// Contains the calculated route's details for each path between a pair of
/// positions. The number of legs returned corresponds to one fewer than the
/// total number of positions in the request.
///
/// For example, a route with a departure position and destination position
/// returns one leg with the positions [snapped to a nearby
/// road](https://docs.aws.amazon.com/location/previous/developerguide/snap-to-nearby-road.html):
///
/// * The `StartPosition` is the departure position.
/// * The `EndPosition` is the destination position.
///
/// A route with a waypoint between the departure and destination position
/// returns two legs with the positions snapped to a nearby road:
///
/// * Leg 1: The `StartPosition` is the departure position . The `EndPosition`
///   is the waypoint positon.
/// * Leg 2: The `StartPosition` is the waypoint position. The `EndPosition` is
///   the destination position.
pub const Leg = struct {
    /// The distance between the leg's `StartPosition` and `EndPosition` along a
    /// calculated route.
    ///
    /// * The default measurement is `Kilometers` unless the request specifies a
    ///   `DistanceUnit` of `Miles`.
    distance: f64,

    /// The estimated travel time between the leg's `StartPosition` and
    /// `EndPosition`. The travel mode and departure time that you specify in the
    /// request determines the calculated time.
    duration_seconds: f64,

    /// The terminating position of the leg. Follows the format
    /// `[longitude,latitude]`.
    ///
    /// If the `EndPosition` isn't located on a road, it's [snapped to a nearby
    /// road](https://docs.aws.amazon.com/location/previous/developerguide/nap-to-nearby-road.html).
    end_position: []const f64,

    /// Contains the calculated route's path as a linestring geometry.
    geometry: ?LegGeometry = null,

    /// The starting position of the leg. Follows the format `[longitude,latitude]`.
    ///
    /// If the `StartPosition` isn't located on a road, it's [snapped to a nearby
    /// road](https://docs.aws.amazon.com/location/previous/developerguide/snap-to-nearby-road.html).
    start_position: []const f64,

    /// Contains a list of steps, which represent subsections of a leg. Each step
    /// provides instructions for how to move to the next step in the leg such as
    /// the step's start position, end position, travel distance, travel duration,
    /// and geometry offset.
    steps: []const Step,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration_seconds = "DurationSeconds",
        .end_position = "EndPosition",
        .geometry = "Geometry",
        .start_position = "StartPosition",
        .steps = "Steps",
    };
};
