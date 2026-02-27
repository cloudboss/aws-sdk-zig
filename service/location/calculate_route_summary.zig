const DistanceUnit = @import("distance_unit.zig").DistanceUnit;

/// A summary of the calculated route.
pub const CalculateRouteSummary = struct {
    /// The data provider of traffic and road network data used to calculate the
    /// route. Indicates one of the available providers:
    ///
    /// * `Esri`
    /// * `Grab`
    /// * `Here`
    ///
    /// For more information about data providers, see [Amazon Location Service data
    /// providers](https://docs.aws.amazon.com/location/previous/developerguide/what-is-data-provider.html).
    data_source: []const u8,

    /// The total distance covered by the route. The sum of the distance travelled
    /// between every stop on the route.
    ///
    /// If Esri is the data source for the route calculator, the route distance
    /// can’t be greater than 400 km. If the route exceeds 400 km, the response is a
    /// `400 RoutesValidationException` error.
    distance: f64,

    /// The unit of measurement for route distances.
    distance_unit: DistanceUnit,

    /// The total travel time for the route measured in seconds. The sum of the
    /// travel time between every stop on the route.
    duration_seconds: f64,

    /// Specifies a geographical box surrounding a route. Used to zoom into a route
    /// when displaying it in a map. For example, `[min x, min y, max x, max y]`.
    ///
    /// The first 2 `bbox` parameters describe the lower southwest corner:
    ///
    /// * The first `bbox` position is the X coordinate or longitude of the lower
    ///   southwest corner.
    /// * The second `bbox` position is the Y coordinate or latitude of the lower
    ///   southwest corner.
    ///
    /// The next 2 `bbox` parameters describe the upper northeast corner:
    ///
    /// * The third `bbox` position is the X coordinate, or longitude of the upper
    ///   northeast corner.
    /// * The fourth `bbox` position is the Y coordinate, or latitude of the upper
    ///   northeast corner.
    route_b_box: []const f64,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .distance = "Distance",
        .distance_unit = "DistanceUnit",
        .duration_seconds = "DurationSeconds",
        .route_b_box = "RouteBBox",
    };
};
